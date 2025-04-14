/// @file
///	@ingroup 	minapi
///	@copyright	Copyright 2025 The Min-API Authors. All rights reserved.
///	@license	Use of this source code is governed by the MIT License found in the License.md file.

#pragma once

#include <magic_enum/magic_enum.hpp>

namespace c74::min {

/// Check for legacy enums which explicitly define 'enum_count' as the last value in the enum,
/// rather than automatically parsing the count using magic_enum.
/// This is required since the magic_enum::enum_count<T> would be incorrect for such legacy types
/// (1 greater than intended value due to magic_enum also counting the `enum_count` value)
template <typename T, typename = void>
struct has_explicit_enum_count : std::false_type {};

template <typename T>
struct has_explicit_enum_count<T, std::void_t<decltype(T::enum_count)>> : std::true_type {};

template <typename T>
inline constexpr bool has_explicit_enum_count_v = has_explicit_enum_count<T>::value;


template <typename T>
constexpr auto enum_count() noexcept { return magic_enum::enum_count<T>(); }

template <typename T>
constexpr auto enum_values() noexcept { return magic_enum::enum_values<T>(); }

template <typename T>
constexpr auto enum_name(T value) noexcept { return magic_enum::enum_name(value); }

} // namespace c74::min