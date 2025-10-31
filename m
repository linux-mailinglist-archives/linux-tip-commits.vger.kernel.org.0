Return-Path: <linux-tip-commits+bounces-7116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD0C26177
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3E74F9908
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2982F1FFE;
	Fri, 31 Oct 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJBEuT9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55952E1743;
	Fri, 31 Oct 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927108; cv=none; b=m4sYWfIwlZeJ0QSi+cLp9cZIk9XMuOud/Bwi7LK4dzJnr2uRO9Aa3o2cx4JigvEUSARRfbio80K7dlSdXSgDMdyKZ1ZO4xcGuLmfxg7EcfP+pMbmjvklgwGZrPSrO5FaBbSH79DZAtMEKzr856Is7En3KmdthjGpM6bGfoaqaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927108; c=relaxed/simple;
	bh=I9XiT2VOYadGpBiHCveuZ7NxW9OkwQU5rIaS1OCQfNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAus2vG/BI8Hs4kUR2j+a6RAis874wam3c1A3SqpQpp0qUTairg5HujjgPqgoYKsOLD0Pg1orC4RQ5WxOn6EWmru9hfGKCaOPrOsWZzJb43Xk2butLl+sZ4CX/pdslBXAWJXNhShhHPWORwWd9O9HST2v4NYDpKKCKEZJvTHBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJBEuT9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDD9C4CEE7;
	Fri, 31 Oct 2025 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761927107;
	bh=I9XiT2VOYadGpBiHCveuZ7NxW9OkwQU5rIaS1OCQfNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJBEuT9XLTXTCIzh8f1RTXbdeZzqp+14jqqhBFkTTWzkBhaKlsp9WQK68emRMvomi
	 2XkYnHiGi3sZt4FxceS0+N0DOCji187kuN2ygQXVc7ol72/K9IPI/zZj5c7lBap/LA
	 xaC16HXS5NV7Nlc6rDPAvq6Zg+1+GDrDEefSXGGV4yY/V1JDrqhZl0eGPi4UaRjcJQ
	 eZo3c0hKxbav2zaeWw8IC70deym8PoZpSYmU0pfezOLjWnlPFeYx1Ufeh2Le1Up9ON
	 xWEePX6RuSlmtE33kbS5kFMkocvCegjuHzYZRsfHOSLS2O7N8Sh1QV1ZH3DGPv3AAN
	 P34YuJFCiWrXA==
Date: Fri, 31 Oct 2025 09:11:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/klp: Add --debug option to show
 cloning decisions
Message-ID: <wi54qqmdbzuajt7f5krknhcibs7pj45zhf42n3z5nyqujoabgz@hbduuwymyufh>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
 <20251031140944.GA3022331@ax162>
 <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>

On Fri, Oct 31, 2025 at 03:21:00PM +0100, Borislav Petkov wrote:
> On Fri, Oct 31, 2025 at 10:09:44AM -0400, Nathan Chancellor wrote:
> > Yeah, that looks good to me and matches the workaround that Peter did in
> > include/linux/compiler-clang.h. If cleanup is going to be used more in
> > objtool, it might be worth taking that approach there too like:
> > 
> >   #ifdef __clang__
> >   #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
> >   #else
> >   #define __cleanup(func) __attribute__((__cleanup__(func)))
> >   #endif
> 
> LGTM.
> 
> I'll wait for the objool-er folks to lemme know what they want before
> I productize it.
> 
> Thx Nathan!

How about __maybe_unused unconditionally without the #ifdef damage?

-- 
Josh

