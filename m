Return-Path: <linux-tip-commits+bounces-4058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382DA575ED
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061B83AE63F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BCB258CDF;
	Fri,  7 Mar 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqwuO900"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E187219E8;
	Fri,  7 Mar 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389721; cv=none; b=IDQYHZQtA0O95AjlgM5DcQ2RABcFSKXYXN2jhU1/nfQh1FFT67ncyuOK/Ph0iGYLhNfGLwk4/353y9616x3E8t/D8TkS8L5ImtcPyPDvu+DOrvhTqtdXlCzWYQ8X7pyhy4W0e4s0Y0U7zCYztOPC/4wvMQVNTIIQVFfTUAMHVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389721; c=relaxed/simple;
	bh=Sh5CAa9QPT9G3U65/cuQbm62/4aSJbmfJVZz9dWhH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJF2j6BkkK1ir6de48NjbdkNbvzmoTUVe7/sNgMkJkUllOPyqWW74anLz6HMhKQZCAtH70VXSntby6ms820YFVt4GSyMGemQ1Xk821stCkf8bLI4mSNBZiGbBkc723tlLKjReOpGCLd5mJHbe9FrYXTrQEx8pwrVfCKD51nKQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqwuO900; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5CDC4CED1;
	Fri,  7 Mar 2025 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741389721;
	bh=Sh5CAa9QPT9G3U65/cuQbm62/4aSJbmfJVZz9dWhH9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqwuO900PrZBG+QQUQsPOAyTw/KygQZCo6gzXBJ9DD5Q3d8DVDjZtkiRo47MkNnct
	 MGzLx0jHoZlOHtxc8GcNL3xbdnqQuPBYuClUNPkTdZZ7AGd5ZdKqCVwbKivJNnhBEJ
	 9YtWzRis1oeB65M2CMh2Gu6JQZGVArXBWChUEc6tulHScRZjTLzqXhYw42DGxB5FrR
	 SwoGpwhSut3m4uhXJOWxFFU1zl2Rw4SyC9SYKvqkiT2tRk4LEZdttowLO6RUT9yfzY
	 9WNpz+BpBYa5x4WAQWcDAuhmNDbJ8SD4guztXVlPXA+fZhfTq2v94DF6Vnuo1gCCbY
	 u91yVnpAkL3PQ==
Date: Fri, 7 Mar 2025 15:21:57 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250307232157.comm4lycebr7zmre@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
 <Z8t7ubUE5P7woAr5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8t7ubUE5P7woAr5@gmail.com>

On Sat, Mar 08, 2025 at 12:05:29AM +0100, Ingo Molnar wrote:
> 
> * H. Peter Anvin <hpa@zytor.com> wrote:
> 
> > > #endif /* __ASSEMBLY__ */
> > 
> > So we are going to be using this version despite the gcc maintainers 
> > telling us it is not supported?
> 
> No, neither patches are in the x86 tree at the moment.

FWIW, the existing ASM_CALL_CONSTRAINT is also not supported, so this
patch wouldn't have changed anything in that respect.

Regardless I plan to post a new patch set soon with a bunch of cleanups.

It will keep the existing ASM_CALL_CONSTRAINT in place for GCC, and will
use the new __builtin_frame_address(0) input constraint for Clang only.

There will be a new asm_call() interface to hide the mess.

-- 
Josh

