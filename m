Return-Path: <linux-tip-commits+bounces-5075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF3A936E5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9153BD6B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15D27466A;
	Fri, 18 Apr 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl6XTcIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320772741B9;
	Fri, 18 Apr 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978308; cv=none; b=MuDSsU4srqsC9nrOrjdTUy9pBJujspPL7ArDca1gfMiouTh2mjuWTOwoaXpZROD4+Y3sn5EuDDvqLmpDidw4mEWMRALL6HgQKs0QnqPgFxHOaNMgzHtgn0cBOP0GC2nsRqzebsdhy93wxWUo0+h29FsWQfv5F9PEOhnjj+IP6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978308; c=relaxed/simple;
	bh=i1GAHaPRubCG+Ok7kknHanKt2FeoM7pX/uRadDM54Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQy7I56xH3yeAyJOv7Mhs7+9gsg4kyeE5992/l7tQgra3WsQdv3Of+elcOBYz16cShF4d14VH8taESxWskpHbx3ypqnPXmltKUVju7q4f8hbAcTbojjqmOanOKkf5AkEDRqx4L3VqUzkCgxx7z0WfHuBG0uEnrnKywuK5qUL1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl6XTcIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82647C4CEE2;
	Fri, 18 Apr 2025 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744978307;
	bh=i1GAHaPRubCG+Ok7kknHanKt2FeoM7pX/uRadDM54Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl6XTcICYGhT6VhVHA+Yn+C+X9+gT+2Jv4FxrWuA/NW7mrkhQmEoMblCOy9tHKR1L
	 YVhOXXm+zJOunbrfyObtpbkiT9Xc2EolZrkYGNSg+gzeqoFhBStwcw4KxHnLSYDfkw
	 I4RYO6ZeOy3ZisYtMejKZ2EJY68gbb/4fqH6zXf9LYP+RqL0rgzdwJb4fOKV7b+b2g
	 SIVDPEign+sgyySIIM7I90qhgLz4tfJKdVTHKT485TePajyW/xaYOWQQiOhwyBmmbz
	 T4GPRiXrqWN0O8xlSCV763yTjP34byu2/P55+q6+wH4y/GfoPss9LlUs8B5JpCnR8d
	 d8DUI121wa33Q==
Date: Fri, 18 Apr 2025 14:11:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <aAJBgCjGpvyI43E3@gmail.com>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>


* Borislav Petkov <bp@alien8.de> wrote:

> > Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com
> 
> This needs
> 
> Cc: <stable@kernel.org>

No, it doesn't really 'need' a stable tag, it has a Fixes tag already, 
which gets processed by the -stable team.

Also, the bug is old, 1.5 years old:

  Date: Sat, 2 Dec 2023 12:50:23 +0100

plus the erratum is a perf-counters information quality bug affecting 
what appears to be a limited number of models, with the workaround 
likely incorporated in BIOS updates as well. Leave it up to the -stable 
team whether they think it's severe enough to backport it?

Thanks,

	Ingo

