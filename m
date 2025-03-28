Return-Path: <linux-tip-commits+bounces-4584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D098A7522D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 22:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5114C3A066A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB571D90D9;
	Fri, 28 Mar 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozq9w1e7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A918A92D;
	Fri, 28 Mar 2025 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198471; cv=none; b=PGHZItjchFHlfICjcZY6v/RMMBZYt/+TQ5SyGM8qnbT+lHsY4Z9FQkGPlHIZUn6FPqbVdNKLZqbwSFLBnkqOECL8GiMmiXGuBNN+qnYVofdqgcPSR2Tkvl7idjcndiPe65cj0r1Pe3f4wQRacaw6wruTCrh8b1MR30naCuX4PZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198471; c=relaxed/simple;
	bh=xPBOsFaDqAzdeekjrQqYOX4avtGoqfLZWowK1nkfdfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOC6P2wVMOANeGwRvvab07NU1XX4TCPdMXbIozuoakMt+mQRGSIEC8Ea0J8U87+nqi6SlJGwLYlgN/JQMOpfyaLXcOS2qSYXGD3MRd6ptsv0pBF+TiiGVI5qA9KWaf/WN6pBq0ZH+hHNx7ZydwY+GivMpe3yjIoyBuhyNkIGiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozq9w1e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC98C4CEE4;
	Fri, 28 Mar 2025 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743198470;
	bh=xPBOsFaDqAzdeekjrQqYOX4avtGoqfLZWowK1nkfdfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ozq9w1e7RAneqNHVfj4TYH28AgLtjM3+iDINbPIILwksUJL0S0epejOt+kvD76Yqe
	 xGmUhvIxw/UyVprJbDqKMrT4nVvelVPjCXcZFofnUQMynKsaRKuwTEAt9kscdLX82H
	 ctdV/SxNhRsjYb6eALMabI30llnsIUDgtxfunoxSQNxTO+fiiNZxXo1vc6Y8CPsIxv
	 mjBJ6QgMY+eDgLZJyQlcKVLJAesHyeRqLFfhK6lDaW3TXwkr/ufNZiciGAa0wsecNQ
	 b7jFrafL9JMYM1COe8yZSHwzR9yU50yU1sV0x8KS44kvEQTlghC8DIiMdA/8dm6pX+
	 XXHvB4kc5unKQ==
Date: Fri, 28 Mar 2025 22:47:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Ondrej Lichtner <olichtne@redhat.com>,
	"Herton R. Krzesinski" <herton@redhat.com>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/uaccess: Improve performance by aligning
 writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs
Message-ID: <Z-cZAmfQqXi3bw2c@gmail.com>
References: <20250320142213.2623518-1-herton@redhat.com>
 <174319666347.14745.18304475049279156644.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174319666347.14745.18304475049279156644.tip-bot2@tip-bot2>


* tip-bot2 for Herton R. Krzesinski <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/mm branch of tip:
> 
> Commit-ID:     411d2763b3ba0e3a99cd27ce813738d530b2320d
> Gitweb:        https://git.kernel.org/tip/411d2763b3ba0e3a99cd27ce813738d530b2320d
> Author:        Herton R. Krzesinski <herton@redhat.com>
> AuthorDate:    Thu, 20 Mar 2025 11:22:13 -03:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 28 Mar 2025 21:56:49 +01:00
> 
> x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs
> 
> History of the performance regression:
> ======================================
> 
> Since the a series of user copy updates were merged upstream
        ^^^^^
> ~2 years ago via:

That was my mistake in a last-minute edit to the changelog.
I force-pushed a fix:

  |  Since the following series of user copy updates were merged upstream
  |  ~2 years ago via:

Thanks,

	Ingo

