Return-Path: <linux-tip-commits+bounces-3838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E828A4CEBC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 23:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4502F7A5CFB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5CF2135C7;
	Mon,  3 Mar 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZimRoN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736341EEA2A;
	Mon,  3 Mar 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042080; cv=none; b=JSBzXu6cQgSjjvTv34s7NVC5UXT0DnkztyuZOEz5+DFPBg2W8VMN2KiqAvVbyoDRSMKUbIWzjKTp2QB3BsJ0D037znc6alOLUEZyBDbE/Zuey1mpx+GBNtHYdMt57PsO+YPWrryYurR5K/Funb7EbAtJbOaI3L6G/ZZx0wASymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042080; c=relaxed/simple;
	bh=zneKY02W1dS4Z00QLqYTizBGsIR00LGBrkW1qseyniI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOWvzsRxiGKpRh0GQmj6Atj3Fr2PAqbmghRaiZCQnM/dVTSYG+1rdDCQVol1Hws0kxQS7b/lV1se7kLtN4qEKliWplMNeLJ044vSLyr6lSsgQPbwpZiJFdLFbSQMBZ9GizY/+7GqAML+CHQTji+ROgKG4I/mA8RdZDrlAUeBqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZimRoN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9189AC4CED6;
	Mon,  3 Mar 2025 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042079;
	bh=zneKY02W1dS4Z00QLqYTizBGsIR00LGBrkW1qseyniI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZimRoN73da7Tkc/ZFIKymm8pkSKI8FBmI/yrByJujX+Dy56RwyBsR+xvvzoEJPF3
	 Eush9OoY5ARFV8nbx27i6I9oxfKSSsJNiPNfPXGNZwutvdu0CaYSHYIxfLpexi9FCA
	 b9hAg/NRIwP/eXR+tXLYtftzgKpNNjxfXiX0XooiL2rlUmOyUuFpnzZBqX9WdlZ9b4
	 NwS3HVi3mXMPkx9Hrzkm023PGx9DBqTx1hORtsYd4JyMQeK/UnOp737iUJELqbJ84G
	 JJ+MhCBDYAGDnYBNhim9PxAnoAwKu77Hv3Ns4F5/WyjWn/wb1jT7GLt4M2M0dhkf03
	 gXZIn1mcKmuHw==
Date: Mon, 3 Mar 2025 14:47:58 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250303224758.2ugmmy7f7zsqti4m@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com>
 <20250303224548.pghzo2j4hdww7nxt@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303224548.pghzo2j4hdww7nxt@jpoimboe>

On Mon, Mar 03, 2025 at 02:45:50PM -0800, Josh Poimboeuf wrote:
> On Mon, Mar 03, 2025 at 02:31:50PM -0800, H. Peter Anvin wrote:
> > >+#ifdef CONFIG_UNWINDER_FRAME_POINTER
> > > #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
> > >+#else
> > >+#define ASM_CALL_CONSTRAINT
> > >+#endif
> > > 
> > > #endif /* __ASSEMBLY__ */
> > > 
> > 
> > Wait, why was this changed? I actually tested this form at least once
> > and found that it didn't work under all circumstances...
> 
> Do you have any more details about where this didn't work?  I tested
> with several configs and it seems to work fine.  Objtool will complain
> if it doesn't work.
> 
> See here for the justification (the previous version was producing crap
> code in Clang):

Gah, that link doesn't work because I forgot to cc lkml.

Here's the tip bot link:

  https://lore.kernel.org/all/174099976253.10177.12542657892256193630.tip-bot2@tip-bot2/

-- 
Josh

