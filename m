Return-Path: <linux-tip-commits+bounces-3837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE1A4CEA7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FCB1695FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4B33F6;
	Mon,  3 Mar 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p36ZhGwX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8ADEC4;
	Mon,  3 Mar 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041951; cv=none; b=pvKYpS1Gv2zC5E2IalCB2ZlEdrkRBNOvop7166k0R41+f0oMHWAA72nQ9pLS2V84oaoRtoMzacJ8rhmM+6yiiv2HS3oRFXtEP+AeT2hTWe57orC+DmtPCKo3SvC9qn4i/O8Ys0yLuvCkKY3EvRf5qekcHbiVAtROxifVZ/QPh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041951; c=relaxed/simple;
	bh=HRCtB39QEYB0RXLZEtY3FMWatuIIo1+rC3OO0u6DFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em4ExfZBA46B37E3GpvlVGTJONbk82Kx7IkHtGMggZCbNXpRetzysuKK/Sit2HECA5VJcObivI5T+zjUIadyDhceNw1UOAm4Qhcpd3M93m3mPyr1Q0dEO5SF0H4zkBnqx1oMQWqrwZ1+0BIr2jX60b5aTHkesxcm3DQum/zCcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p36ZhGwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36281C4CED6;
	Mon,  3 Mar 2025 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041950;
	bh=HRCtB39QEYB0RXLZEtY3FMWatuIIo1+rC3OO0u6DFUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p36ZhGwXpGfPRHuyNwPo9GIViC6Bx7LN8jM2bsfFRcOZ6Yitmwscfb/g+rKmqm4hv
	 qXglpDxJ4DiK/K+hbdR6YwIcrEYPq+Nz8O+ErHfwwtxJa+gB2CUSm+2pc8k1QfmcFm
	 vWawBQyyA4QbLgvk2gb6jad0G+J5NiKgu+BBzTnYr8CzRxGRmcYVU/YCN6ncdmaxpp
	 7glnmy5BgtoBbulJ5FOvoU4NGCGmKgUin1JlJPhbfbxMA7hneUpxNFMQ69tiaC0GWJ
	 qfKb5eBjKczAQSaNo88ow0SKSU17FFfbHJ8EfOI3vG8YYEC2wzDhQsm+eekPtfgnjr
	 lk1TpUoKvGLvQ==
Date: Mon, 3 Mar 2025 14:45:48 -0800
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
Message-ID: <20250303224548.pghzo2j4hdww7nxt@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com>

On Mon, Mar 03, 2025 at 02:31:50PM -0800, H. Peter Anvin wrote:
> >+#ifdef CONFIG_UNWINDER_FRAME_POINTER
> > #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
> >+#else
> >+#define ASM_CALL_CONSTRAINT
> >+#endif
> > 
> > #endif /* __ASSEMBLY__ */
> > 
> 
> Wait, why was this changed? I actually tested this form at least once
> and found that it didn't work under all circumstances...

Do you have any more details about where this didn't work?  I tested
with several configs and it seems to work fine.  Objtool will complain
if it doesn't work.

See here for the justification (the previous version was producing crap
code in Clang):

  https://lore.kernel.org/dbea2ae2fb39bece21013f939ddeb15507baa7d3.1740964309.git.jpoimboe@kernel.org

-- 
Josh

