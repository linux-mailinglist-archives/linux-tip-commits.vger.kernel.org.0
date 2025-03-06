Return-Path: <linux-tip-commits+bounces-4032-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F072A55396
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A316DE01
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C526A0DD;
	Thu,  6 Mar 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAdCSqQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18D269CE8;
	Thu,  6 Mar 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283664; cv=none; b=qy1CgxleBKHRBdDDfJC+q7oDIFV2Dxgfsagh79+jpANJLcxJr5WYtyBTD4QrallNZcINEBcXI7mXvBNf4bezzUdtwKL/G9xHHhQq4V6B8HM86fNaEkggg2g+pMsYgU+4InPajxFy2fUJs6XfqWvtwbsEYb6E0mzdt9E0h5NI0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283664; c=relaxed/simple;
	bh=HOTfJ1QXXP4CgH7Tvks0Ox/LEt7X49JaIPOsEMYIiyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXfD/8aVA0TUfOmfqRGoGCBG7b7MZbD+4RI7AgL3vHahuQI9CMwxkWSSNszODRjjlUISzJDNHqAIpHhnevbU5gyWzxEkr3GuVDxbYqjizJ0n+tZ+nvuX97i3xR+P5CsRAukYcZoAc90FlMbhJrz9twZFXsN5RPDqMJLz8m4x4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAdCSqQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1AC4CEE9;
	Thu,  6 Mar 2025 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283664;
	bh=HOTfJ1QXXP4CgH7Tvks0Ox/LEt7X49JaIPOsEMYIiyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAdCSqQtlyo7/hMbTRNauz/qKbpGDypROcXt8aDYV+GIOftCnaDwxPWMFK69C8YjE
	 X5A6a22WzlgbLoi9fkM465b906EUIScA1d583wfRS9bZT7W4OtGN1MNjt9pCN5nI+K
	 GiF5NQCpyLzH65OWxy3t4lQDIy7VCWXQzHps/a1lbUJJj6WAz2xJug9zTMny/lzNZp
	 0PtPEypRoizrjG5jBWB1EZ+xADgqBGpToPkTRi/bsJR9oh99FUzsxrrGv5G4q9sU2p
	 R2ds8DXqgrfxzqU7zzCpYwBRqoNh3cZymBd2ySZD6d8PYtRzP1lJ9WmrCOYxEy5ODL
	 WqwUaNR0y/2BA==
Date: Thu, 6 Mar 2025 09:54:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
	x86@kernel.org
Subject: Re: [tip: x86/fpu] x86/fpu: Improve crypto performance by making
 kernel-mode FPU reliably usable in softirqs
Message-ID: <20250306175422.GH1796@sol.localdomain>
References: <20250304204954.3901-1-ebiggers@kernel.org>
 <174126241675.14745.2521678635311279694.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174126241675.14745.2521678635311279694.tip-bot2@tip-bot2>

On Thu, Mar 06, 2025 at 12:00:16PM -0000, tip-bot2 for Eric Biggers wrote:
> Performance results:
> ====================
> 
> I did some benchmarks with AES-XTS encryption of 16-byte messages (which is
> unrealistically small, but this makes it easier to see the overhead of
> kernel-mode FPU...).  The baseline was 384 MB/s.  Removing the use of
> crypto/simd.c, which this work makes possible, increases it to 487 MB/s,
> a +27% improvement in throughput.
> 
> CPU was AMD Ryzen 9 9950X (Zen 5).  No debugging options were enabled.
> 
> [ mingo: Prettified the changelog and added performance results. ]
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Link: https://lore.kernel.org/r/20250304204954.3901-1-ebiggers@kernel.org

Thanks!  To clarify, the removal of the use of crypto/simd.c from
arch/x86/crypto/, which is what gives the measured performance improvement,
happens in a separate patch
https://lore.kernel.org/r/20250220051325.340691-3-ebiggers@kernel.org/ which
depends on this one.  I'll try to get applied to the crypto tree in 6.16
(probably split into multiple patches).

As I've mentioned, there can also be a much larger performance improvement in
certain cases where the slow fallback path was being taken, or when users were
requesting a synchronous algorithm and therefore couldn't use the AES-NI code.

- Eric

