Return-Path: <linux-tip-commits+bounces-7117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE8C26E41
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 21:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34AF94E2372
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0055E32862B;
	Fri, 31 Oct 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHYMpYLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2E283FD6;
	Fri, 31 Oct 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942331; cv=none; b=NBh8u+eVCT09+BqBPRZG23oR7LtOWk+6/FNEm+d6w6KDY9cHL4lethk5fSy31r1vIiSnV38cx769zmmAXZSlIlBoZKpW8nfkCYxCjixvP5Ei9NJ84s+rmczyaGOoRjkNkxsj/tFlwDwV/I8O03Eo4VJ3tDgjAa1viZ3RNKKw098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942331; c=relaxed/simple;
	bh=ekWfu0jFUCvipEAA7CjOSxLrpj/17ejOSajkemq7+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxNxnKDU/My6olpBCgc7B/eeXT/uRsbpwF2Dxc4Vhuvc9LxJ95xEZXtcOws64IuB3OSkiceaRF0RmdS2Kico2YpyBWvKuplYo4sC+nZrR9tExULla3sS4RImZ32pu7sHUxaixfHbzE34UqGMo8GJGzeWZ8ClCFK3s8hzdLnR/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHYMpYLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0A7C4CEE7;
	Fri, 31 Oct 2025 20:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761942331;
	bh=ekWfu0jFUCvipEAA7CjOSxLrpj/17ejOSajkemq7+RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHYMpYLF5pe34hRnZrK1ExWTV+KBRS2sMbJZmh4Un+w4/keZ+g8fIwnshpP9ODSZu
	 KlLekXpe4GYiOU7DR9v9qEZ5QHnPe746Il3G9oVUofiVTw+LFoqusgPjC5lt+EbHBZ
	 vw3SD6APCa8Sp95c+jaZfTSG9cMn8WxZOjWZsvdemgYs2dLTvAiDChXDIlJ2yQCb5q
	 fi0jOfcuPXmJWqWc3bWbPRFmJlePfOKui0qo1fEkZu9xwQhA4pBtoGa41+Y8+87TJz
	 WeAe4B6ZIRF1V4Rm521Yx4kvi+c0vneVoNoberCbWbpFLDu8G6YWfB/h6hhhV7Egzt
	 WdhEP82bpkWQw==
Date: Fri, 31 Oct 2025 16:25:26 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/klp: Add --debug option to show
 cloning decisions
Message-ID: <20251031202526.GB2486902@ax162>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
 <20251031140944.GA3022331@ax162>
 <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>
 <wi54qqmdbzuajt7f5krknhcibs7pj45zhf42n3z5nyqujoabgz@hbduuwymyufh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wi54qqmdbzuajt7f5krknhcibs7pj45zhf42n3z5nyqujoabgz@hbduuwymyufh>

On Fri, Oct 31, 2025 at 09:11:44AM -0700, Josh Poimboeuf wrote:
> On Fri, Oct 31, 2025 at 03:21:00PM +0100, Borislav Petkov wrote:
> > On Fri, Oct 31, 2025 at 10:09:44AM -0400, Nathan Chancellor wrote:
> > > Yeah, that looks good to me and matches the workaround that Peter did in
> > > include/linux/compiler-clang.h. If cleanup is going to be used more in
> > > objtool, it might be worth taking that approach there too like:
> > > 
> > >   #ifdef __clang__
> > >   #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
> > >   #else
> > >   #define __cleanup(func) __attribute__((__cleanup__(func)))
> > >   #endif
> > 
> > LGTM.
> > 
> > I'll wait for the objool-er folks to lemme know what they want before
> > I productize it.
> > 
> > Thx Nathan!
> 
> How about __maybe_unused unconditionally without the #ifdef damage?

Yeah I had only suggested that to mirror the kernel but fundamentally,
GCC already treats it that way so I don't think there is any harm in
just doing this unconditionally.

Nathan

