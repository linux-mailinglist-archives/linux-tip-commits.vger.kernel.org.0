Return-Path: <linux-tip-commits+bounces-5076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3545A9371C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C4C8A634D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928CA221F0C;
	Fri, 18 Apr 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDy5clta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3A78F3B;
	Fri, 18 Apr 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979550; cv=none; b=WDHBqhWF7kYkq9NmfF26eZpOf3n5nO/9YcoT/hytgoz4kjA+ohUbrduorE9z1UxhJ53YRlf1xT0vqpBqNnXi6dP9kz5gaaMR1UvwtuamfWzbzaTyllLdbays7nO0SsfXzh2FcpQhOennCn5Iu1R2suJMDAkIegzeiLF56NMPijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979550; c=relaxed/simple;
	bh=U2YQdKkw5xULbb02aJnZgMz5IzQN9XJtihtLVdheXZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6z6GXz0Vf72+53G5u/425NWHgLVTofJlEU3WRjDDeApoeDvQLCOlLxJadYQ5tY6nm/IZx2GOCqbLxO4uoY1VvvyTnciZdVKQvwz/zrNDXf5sPbJQimNCYMCfP9dANzXD1VSTagsaeI4nFc6dafTPg5LnNmcT1HmDjRovoqElD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDy5clta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB303C4CEE2;
	Fri, 18 Apr 2025 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744979549;
	bh=U2YQdKkw5xULbb02aJnZgMz5IzQN9XJtihtLVdheXZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDy5cltaOMPs0cUpPQIzqg3+fdeOAQf6FOB4kSu2K1al3GMXtsGXYqlM3KQVBwELu
	 UA+Kz8bC+qHkYNrilpLNuzEbgznV2le2Y0go8HhGNIEYckD0zLfcnkSbI2GCkNxjHk
	 fLnCMa92GaTFOeJifHNqLnfCP5lkrZDS5k3O1qOGi29CJm/pJOMVspaLungsURWzg0
	 IwkRAPa7/x6Y/S5WZPoT/PfKbJJVuOVdcBE0QcA+tKCoHxb01X3vsT+F+5VRWIxXjt
	 Y+9cramiwSfMmz4jQVLZ7j5tGeHUzcX0OOGgmhTox3Mf2yJ+RCDoMAtzUBf6I1MDB3
	 qDtXe5Es8MZLA==
Date: Fri, 18 Apr 2025 14:32:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <aAJGWpiT6ZwQgIFU@gmail.com>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
 <aAJBgCjGpvyI43E3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAJBgCjGpvyI43E3@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > > Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
> > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Link: https://lore.kernel.org/r/caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com
> > 
> > This needs
> > 
> > Cc: <stable@kernel.org>
> 
> No, it doesn't really 'need' a stable tag, it has a Fixes tag already, 
> which gets processed by the -stable team.

Anyway, I agree with you that it cannot hurt to have a Cc: stable,
so I've added the tag along with your Acked-by, thanks Boris!

	Ingo

