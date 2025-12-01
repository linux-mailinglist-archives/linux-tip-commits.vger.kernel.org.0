Return-Path: <linux-tip-commits+bounces-7569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C4C9914D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87C6D34470D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD823D7CA;
	Mon,  1 Dec 2025 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRPNNrQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134482080C8;
	Mon,  1 Dec 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622195; cv=none; b=Ltrt8pDwH7GULqW1CsUjLsYvuqo5L3Rl7pvo9RVC/Y+/C8wmME8w5X1tFGAdqMOJ+F6UY7k1A+eEWr6GJq/GsDniUfFO3cZneKs9e66eZjR+suAiE92hRYX2sUsFl1lYVOTuOi8vsh+JmtJwmRTtg5m+ayf3tVsterKBnJ1Vdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622195; c=relaxed/simple;
	bh=8wAAyHbc6t11DVoygtRnZmrBq8Pr9gWNllgL1faUWnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCerOHwEiclojX+BqqiGbX3zsG63ZA0eASVi0R1RpztguERpPvci538cTgZ4Ww1Q5XZHBMgSkZBcLPzpTxUjbhPh0fZD+StZqDqUvmYstjSIm/LWWdDAHEbYoHc2TatFjt/mxykLo3MCNCaddnCCllMDYRHB+senE5AalT4DmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRPNNrQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06C1C4CEF1;
	Mon,  1 Dec 2025 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764622194;
	bh=8wAAyHbc6t11DVoygtRnZmrBq8Pr9gWNllgL1faUWnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRPNNrQII+ksPapRCpfZrEtKgsvvxX7P1ulaRRYTH9pvofR/z1GFJUx03cj2ug9Mc
	 1Tz5gGEe/2jLqnGVuRAWJcVL3oy1L41Z2AkJE1j2BHv4nBZesywQcxGIc9bO2IlIqs
	 xBSnolbdWmD7SSFrwyiVKCWv3Kqw2fLgLUUgwRRUY05YKgAgFWp81iug4W2OUms2/0
	 95uOav2KLnUs/eakRIV+L+SH+e7kpEJklS6b0r0vAenLaeOjIADcLZN0mq1jh7zWB1
	 3hhoLkaPeJmEpAHmSw13fGiSiBeq3/43WwW3C1aT3qsU9a19wCMuDBBdOKm+d8zcYo
	 h5jICha9Gwe0Q==
Date: Mon, 1 Dec 2025 21:49:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix segfault on unknown alternatives
Message-ID: <aS3_bsNCpnU6RNHG@gmail.com>
References: <176458277141.498.10249599680541531664.tip-bot2@tip-bot2>
 <bl3agkw6xvbnhfper6eljiawlkcb4mq4xjpourjobjhz6wozgd@5u35n26jtc73>
 <3be480e7-8baf-4196-baf4-b9c29f8ef491@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be480e7-8baf-4196-baf4-b9c29f8ef491@oracle.com>


* Alexandre Chartre <alexandre.chartre@oracle.com> wrote:

> On 12/1/25 21:05, Josh Poimboeuf wrote:
> > On Mon, Dec 01, 2025 at 09:52:51AM +0000, tip-bot2 for Ingo Molnar wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > > 
> > > Commit-ID:     6ec33db1aaf06a76fb063610e668f8e12f32ebbf
> > > Gitweb:        https://git.kernel.org/tip/6ec33db1aaf06a76fb063610e668f8e12f32ebbf
> > > Author:        Ingo Molnar <mingo@kernel.org>
> > > AuthorDate:    Mon, 01 Dec 2025 10:42:27 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Mon, 01 Dec 2025 10:42:27 +01:00
> > > 
> > > objtool: Fix segfault on unknown alternatives
> > > 
> > > So 'objtool --link -d vmlinux.o' gets surprised by this endbr64+endbr64 pattern
> > > in ___bpf_prog_run():
> > > 
> > > 	___bpf_prog_run:
> > > 	1e7680:  ___bpf_prog_run+0x0                                                     push   %r12
> > > 	1e7682:  ___bpf_prog_run+0x2                                                     mov    %rdi,%r12
> > > 	1e7685:  ___bpf_prog_run+0x5                                                     push   %rbp
> > > 	1e7686:  ___bpf_prog_run+0x6                                                     xor    %ebp,%ebp
> > > 	1e7688:  ___bpf_prog_run+0x8                                                     push   %rbx
> > > 	1e7689:  ___bpf_prog_run+0x9                                                     mov    %rsi,%rbx
> > > 	1e768c:  ___bpf_prog_run+0xc                                                     movzbl (%rbx),%esi
> > > 	1e768f:  ___bpf_prog_run+0xf                                                     movzbl %sil,%edx
> > > 	1e7693:  ___bpf_prog_run+0x13                                                    mov    %esi,%eax
> > > 	1e7695:  ___bpf_prog_run+0x15                                                    mov    0x0(,%rdx,8),%rdx
> > > 	1e769d:  ___bpf_prog_run+0x1d                                                    jmp    0x1e76a2 <__x86_indirect_thunk_rdx>
> > 
> > The problem is actually that indirect jump.  That's a jump table (not to
> > be confused with a jump *label*) which is an objtool "alt" type which
> > the disas code doesn't seem to know about yet.
> > 
> > They're used for C indirect goto (___bpf_prog_run) and switch
> > statements.  The latter are currently disabled in most x86 configs via
> > -fno-jump-tables.
> > 
> > They're indirect jumps with a known set of jump targets.  It should be
> > possible to graphically display the possible targets with lines and
> > arrows, something similar to "objdump -d --visualize-jumps".
> > 
> > If the code isn't expecting that "alt" type, it might explode in other
> > ways.  So at least for now, those alts need to at least be recognized
> > and ignored.
> 
> I think the problem is with add_jump_table() which 
> creates a struct alternative but doesn't set the 
> type. So it defaults to 0 which is 
> ALT_TYPE_INSTRUCTIONS and then it fails because an 
> alt_group is expected with this type.
> 
> A quick fix is probably to define a new alt_type 
> ALT_TYPE_UNKNOWN = 0 and have disas ignore this type 
> of alternative. I will work on a fix.

Note that we still want the NULL dereference protection 
as well as a fallback, because objtool should always be 
robust against arbitrarily random and faulty input 
data.

Thanks,

	Ingo

