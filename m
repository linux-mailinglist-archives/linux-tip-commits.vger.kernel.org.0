Return-Path: <linux-tip-commits+bounces-3842-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59CA4D163
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 03:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F8188E643
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 02:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430A2B9A6;
	Tue,  4 Mar 2025 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c4KwiHBI"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB02F46;
	Tue,  4 Mar 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053925; cv=none; b=Ya5kZdeHlP2k+QavjN+1YWm3V7uu8gGhe++WYZTf98ns7y/cpIaTEnWdt1lV4e57RoEyWlYS+fckxYS7LDUWq/13GycU1JwDCwNRCoQRopFikpFwUaeJdK3a1DLTPOvqlGYLU5me8ybb5XTHK0bPtMLur33Bc19OULw74dYnjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053925; c=relaxed/simple;
	bh=yBZyz1mdolXu0Q3RyY+DqnuV/lS4Po8UP2Kw13JYse4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kY20teJWy2XoVxM63rNWtgWiK55/r5M5EW0fmfiVIhBYjiMa2sWAxAh8NAzmk/L4SNVTnJRZz4tsCMDVFACFLpte3QiCsizLGRCnCRFhYFsg8bvNoIe+/miBoNiYbW88LfvuI3kgnhZmkb5KD5KmjlHm+go8RohMLy0VlAV8rMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=c4KwiHBI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524259Jg1865183
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 18:05:09 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524259Jg1865183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741053910;
	bh=yBZyz1mdolXu0Q3RyY+DqnuV/lS4Po8UP2Kw13JYse4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=c4KwiHBIHo53jaQyApLHheGK0DtiwZbD0ODuxpU1U9W40b3jSW0yK3xfH8rNPJ79t
	 P7CNFMCl3+a4lprdWnXZMVoSOhNem9DFt6BBEw0h0jXTAtTu8jZdQ2WS0TJdQB3F6f
	 XW0TkCmso+gYxGIMuE2Fo+oNK/SOYlkTTZY8KWVzu6T53sDr74RXOprnWhc0ini5CH
	 kFMLoEwPV+dKUOS2Jz3c+iAQID5dC4q6f1SphtLIPT+vV1bOkMw9+2b2slDz7+6fpF
	 gIgduFxZ8sX5O0SdSercEDw1q7eHSuYL41/jtBUGtYI4JKlbmPLdxEEsiT0XwdJ7v9
	 IHOryPlpzr6SA==
Date: Mon, 03 Mar 2025 18:05:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: brgerst@gmail.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, tip-bot2@linutronix.de,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <c7496069-2630-45ca-b6d3-c8d6b3678271@citrix.com>
References: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com> <c7496069-2630-45ca-b6d3-c8d6b3678271@citrix.com>
Message-ID: <82FF5D6C-15F5-44FE-8436-CDBB9F35FDD5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 4:57:49 PM PST, Andrew Cooper <andrew=2Ecooper3@citrix=2Ec=
om> wrote:
>> One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able =
to use the redzone in future FRED only kernel builds=2E
>
>That's easy enough to fix with "|| CONFIG_FRED_EXCLUSIVE" in some
>theoretical future when it's a feasible config to use=2E
>
>~Andrew

Assuming it hasn't bitrotted=2E=2E=2E

