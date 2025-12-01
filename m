Return-Path: <linux-tip-commits+bounces-7567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C3C98F3C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7A3A3B5C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DDA22578D;
	Mon,  1 Dec 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiBJKUwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7091F5851;
	Mon,  1 Dec 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619552; cv=none; b=XNioKySiJ6GFgPeYdu4sCRcs0NHuA4JEyYMcLsZQsp2YqJUOedcO/yTSMCNFr4Y8UUZf8gprWG2ZND9mN5lwXXAegdx25rDHB437RbaSiVmsDU3E47ynUtHEsotoeHUJKFkh8O0cmUpjNmC/MQLl1O2YHHm5FYQYKShx3dfEipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619552; c=relaxed/simple;
	bh=1TZsDoIbEPmRpeaAGfjUp7jIzgqCPJSQzI91o8oZUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onXHIOlPzG3KhRBUtLeQuXQ6UcHSMi64ivw4jJTMeomoD2lr1UT4BOELM7ZnDrHzlF4sHHh4/xW3aL4LZOukcxJOz0kJ/6NtdPOl37dXPDGpVA1fuTfm6bw8uCklPri9fK/SVqwbZMq2WpscCttkSti4cS3Xp3NcoQC3UYbpnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiBJKUwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305DC4CEF1;
	Mon,  1 Dec 2025 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619552;
	bh=1TZsDoIbEPmRpeaAGfjUp7jIzgqCPJSQzI91o8oZUrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiBJKUwzcUjqL5eugXwFmWRCMPtK2EqGlL3D7ckJQjY370eSFqRL9Z+n0+fMU9Pgn
	 JgNoMjvrRhlun++eVLtELtq5jIRyBNIMoMMN99fcaj//hvICk5DsHXPHeIgOZ35A3n
	 lO8HtQivAw2Cwg7jtnk493L9+R2o0I3owL9YiqFzgwcUMhGLS2pWioqfRWXjT+OzNi
	 A+JsNK59fssjFRI1Ax1vImwaxaDm1egA8l2agrCBmOr/JDpZjEueDm2tOxpaoO5Nov
	 etnI9XxnuIYvoJZFfr/UqFdbfgreBmK4B0FaooKu70BNYTxwQIKbkt0Gmf2PF9Ew2W
	 S+0nKe/iZ3BEQ==
Date: Mon, 1 Dec 2025 12:05:49 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix segfault on unknown alternatives
Message-ID: <bl3agkw6xvbnhfper6eljiawlkcb4mq4xjpourjobjhz6wozgd@5u35n26jtc73>
References: <176458277141.498.10249599680541531664.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176458277141.498.10249599680541531664.tip-bot2@tip-bot2>

On Mon, Dec 01, 2025 at 09:52:51AM +0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     6ec33db1aaf06a76fb063610e668f8e12f32ebbf
> Gitweb:        https://git.kernel.org/tip/6ec33db1aaf06a76fb063610e668f8e12f32ebbf
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Mon, 01 Dec 2025 10:42:27 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 01 Dec 2025 10:42:27 +01:00
> 
> objtool: Fix segfault on unknown alternatives
> 
> So 'objtool --link -d vmlinux.o' gets surprised by this endbr64+endbr64 pattern
> in ___bpf_prog_run():
> 
> 	___bpf_prog_run:
> 	1e7680:  ___bpf_prog_run+0x0                                                     push   %r12
> 	1e7682:  ___bpf_prog_run+0x2                                                     mov    %rdi,%r12
> 	1e7685:  ___bpf_prog_run+0x5                                                     push   %rbp
> 	1e7686:  ___bpf_prog_run+0x6                                                     xor    %ebp,%ebp
> 	1e7688:  ___bpf_prog_run+0x8                                                     push   %rbx
> 	1e7689:  ___bpf_prog_run+0x9                                                     mov    %rsi,%rbx
> 	1e768c:  ___bpf_prog_run+0xc                                                     movzbl (%rbx),%esi
> 	1e768f:  ___bpf_prog_run+0xf                                                     movzbl %sil,%edx
> 	1e7693:  ___bpf_prog_run+0x13                                                    mov    %esi,%eax
> 	1e7695:  ___bpf_prog_run+0x15                                                    mov    0x0(,%rdx,8),%rdx
> 	1e769d:  ___bpf_prog_run+0x1d                                                    jmp    0x1e76a2 <__x86_indirect_thunk_rdx>

The problem is actually that indirect jump.  That's a jump table (not to
be confused with a jump *label*) which is an objtool "alt" type which
the disas code doesn't seem to know about yet.

They're used for C indirect goto (___bpf_prog_run) and switch
statements.  The latter are currently disabled in most x86 configs via
-fno-jump-tables.

They're indirect jumps with a known set of jump targets.  It should be
possible to graphically display the possible targets with lines and
arrows, something similar to "objdump -d --visualize-jumps".

If the code isn't expecting that "alt" type, it might explode in other
ways.  So at least for now, those alts need to at least be recognized
and ignored.

-- 
Josh

