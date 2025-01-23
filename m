Return-Path: <linux-tip-commits+bounces-3285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69FA1A9E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F9E7A1F3E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F914A4FB;
	Thu, 23 Jan 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5YT1/BM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jP9GgAtW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347184A30;
	Thu, 23 Jan 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658962; cv=none; b=K2vZMmIXUVXjMAFb/mtHetSdKqbbckeUTmiPBUINznbVSMtWija1+SjSvxBuaPR24SoCSAyPtaacT2Iuk0LyKm8880B2TW7WLMfPb0VsnslCtV1dwnANzJUPEhb0qfqP888IFYde4FqQEpZCyf0NUd6jJouZd8D5bnqDBDkVJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658962; c=relaxed/simple;
	bh=oVzWRPquJubSsQjxQtU/xsA5REOOh4MsyKyD+P/35qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HEiodiCod8qzi0NGWiJa8UZLRs0FDcuSQFpV+2bn0ojVSrXSpzim06vuxrAwHzRKIZ5t/BTiZzeTgAx0F2OX0M+04Tg9YpGwX4UvwGyChSZSqiMFub5JQw1h49MUT2N2rzcKep+WaEhzzMFsfEUbJs+tqiD2/1/a+HJptGIisII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5YT1/BM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jP9GgAtW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737658958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sppuG0H01JL+10hNwBxO0DQsIsqK2vp8Xikj6I2flY=;
	b=I5YT1/BMnV9YJp44RkPyXEiFLtSbmQ6UtsicDfaBcjYUi5NUDnZFnXoIOnr+BWlQgrDNdp
	HiPh57jbergk0VDjq+oGDWy3JZqylkfa7L3W6wVeW5ICdtd91fjK6DOI4iKSbjjAMx4Ts3
	8YU2r5Mk77V4cpwG9qCe19JUUQs9Q3M3YJ1Lj+GCBlu0dxOBLVUxg6lzmLR3moEs4h/zHF
	hPFJjGUJRAlo9hAJas2jQs3RiI+eEHqImkxi5op4Hx4V/fG6i0C6KolKOrZS7mE9/MkhOQ
	EbK92wPVd21p55YuiyTyFAFrXUhxYZ5xwluLDTgEt8JC07l65TUMLD55xQLPlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737658958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sppuG0H01JL+10hNwBxO0DQsIsqK2vp8Xikj6I2flY=;
	b=jP9GgAtWLIcb32zqT4yeAymxfNFgZtokSgPrLSc57AxSWuJhs/4PKy8wmqLmjjVTFTp9ne
	znJSql5fjnDcViCg==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: timers/urgent] hrtimers: Mark is_migration_base() with
 __always_inline
In-Reply-To: <Z5JUoM70IVkkxo3i@smile.fi.intel.com>
References: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
 <173762985287.31546.13973652433600504292.tip-bot2@tip-bot2>
 <Z5JUoM70IVkkxo3i@smile.fi.intel.com>
Date: Thu, 23 Jan 2025 20:02:37 +0100
Message-ID: <87y0z18ib6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 23 2025 at 16:39, Andy Shevchenko wrote:
> On Thu, Jan 23, 2025 at 10:57:32AM -0000, tip-bot2 for Andy Shevchenko wrote:
>> The following commit has been merged into the timers/urgent branch of tip:
>> 
>> Commit-ID:     3ff6e36be060f0a8870f76155e14de128058b964
>> Gitweb:        https://git.kernel.org/tip/3ff6e36be060f0a8870f76155e14de128058b964
>> Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> AuthorDate:    Thu, 16 Jan 2025 18:07:45 +02:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Thu, 23 Jan 2025 11:47:23 +01:00
>> 
>> hrtimers: Mark is_migration_base() with __always_inline
>> 
>> When is_migration_base() is unused, it prevents kernel builds
>> with clang, `make W=1` and CONFIG_WERROR=y:
>> 
>> kernel/time/hrtimer.c:156:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
>>   156 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
>>       |                    ^~~~~~~~~~~~~~~~~
>> 
>> Fix this by marking it with __always_inline.
>
>> [ tglx: Use __always_inline instead of __maybe_unused ]
>
> Thanks, but it doesn't fix the problem:
>
> kernel/time/hrtimer.c:156:29: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
>   156 | static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
>       |                             ^~~~~~~~~~~~~~~~~
> 1 error generated.

This is insane. Let me undo that for heavens sake.

