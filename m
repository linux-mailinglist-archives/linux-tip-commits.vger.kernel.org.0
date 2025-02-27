Return-Path: <linux-tip-commits+bounces-3710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96FA47C9B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25B03A76DF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E681A4E9D;
	Thu, 27 Feb 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVXP5hFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412456FB0;
	Thu, 27 Feb 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657170; cv=none; b=POdkzBYwCdJeWx94dMebyfNN85SqDZkn5kBY9mkNEBgGqCYor1LVEI7uoezem1fc88KXQ+tlRGyjGIHV0L047rwSwQdiPgrmxKG2yWj7BvVbMQQ8rSvQb4JRT/iCp8obnmfDCUHyWFw+Qe8aoqWkxhzJrvovWEDvdkqRPqh/6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657170; c=relaxed/simple;
	bh=ujqkVTJfbifJmvnrFsGRUAMFLN6TjuZ9+ugO69VY00s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZzAlGofnKR2DCmpEmkYknOiYmsAZHX3xuWd+X4aUpPkprqeY6+jHfjLDG6waB/kGGbjp9sKaOSyFi+JHezx4iFeYZB08qha8cSXA453etdna7eB2x3X6FpSbmBoByyMsUbtaJjGNPWuhNlROhoVnpZ3xQMfnpKLFvkFz69vRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVXP5hFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B2AC4CEE5;
	Thu, 27 Feb 2025 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740657170;
	bh=ujqkVTJfbifJmvnrFsGRUAMFLN6TjuZ9+ugO69VY00s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVXP5hFn1FbbXEVNIk7OD8xPwcZz8tduUnX2xahO+0D23LlUYkRFgKWlGZiSf+4p8
	 UgvW44SPQE987OFztZQ+Tv1TgazJxJ85hh4G1UgxVXCxkef7II7DQpQS7HjHqIuFlM
	 KG2+iI0Gq4QUvZuYrK9EJ2iv2M9X5WoTpz3VZPsCXw9r99xulgarpWAVaQlgKRhhOj
	 wHQJxL23Jknw+IRpspvK9C5IxZWSiGigLYEZHgof8IJIjTpFHsjieMO7VAStgoWfQc
	 tGUD5lEc0El5EmgL1ByZ6VTeVgTurxFt4sEiUHi6RHMyrvEfSEbOwnwsXwVZB9DTyL
	 /NmzgjqReeDMQ==
Date: Thu, 27 Feb 2025 12:51:57 +0100
From: Joel Granados <joel.granados@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/core: Move perf_event sysctls into
 kernel/events
Message-ID: <b67ze5mr5f4xosuu7dhewsbleb57utgfktt5nzpovwszbhljoo@2hvlava7w2hx>
References: <20250218-jag-mv_ctltables-v1-5-cd3698ab8d29@kernel.org>
 <174014677034.10177.14884250079507564395.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174014677034.10177.14884250079507564395.tip-bot2@tip-bot2>

On Fri, Feb 21, 2025 at 02:06:10PM -0000, tip-bot2 for Joel Granados wrote:
> The following commit has been merged into the perf/core branch of tip:
Does this mean that it will make its way to upstream throught the tip
tree? Should I drop it from my series? Will someone pick this up?


> 
> Commit-ID:     8aeacf257070469ff78a998a968a61d0cadc0de3
> Gitweb:        https://git.kernel.org/tip/8aeacf257070469ff78a998a968a61d0cadc0de3
> Author:        Joel Granados <joel.granados@kernel.org>
> AuthorDate:    Tue, 18 Feb 2025 10:56:21 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 21 Feb 2025 14:53:02 +01:00
> 
> perf/core: Move perf_event sysctls into kernel/events
...
> -		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
> -		.mode		= 0644,
> -		.proc_handler	= perf_event_max_stack_handler,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE_THOUSAND,
> -	},
> -#endif
>  	{
>  		.procname	= "panic_on_warn",
>  		.data		= &panic_on_warn,

-- 

Joel Granados

