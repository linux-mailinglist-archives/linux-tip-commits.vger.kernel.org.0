Return-Path: <linux-tip-commits+bounces-6002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DCCAF92AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8464A50CC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7628C2DB;
	Fri,  4 Jul 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZdZ3AEE2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EED14A4CC;
	Fri,  4 Jul 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632408; cv=none; b=hFJNN8s8R82vZBWdLUiP06l6MAXJ4QwFxvpy8WSrep/K94xIdDDghxv63hS9a/B5pbwm9k36RgHBYSSpwfbDTKnSx+ITa2x5PCW15Y5EY+zN+TRLwfd+t3REE9qz3nmM+e/Ec4JmUOZRcKUHFIYTPBzKrHSnQioNkJsb5lais0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632408; c=relaxed/simple;
	bh=0GjD73X7k8nBQVWH+4jf2QOikjK73rbaYEubmGDkpTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wlake/w1vSlznEvSilNO1QidpEahUOnaJ5iEMuF5S9XqmoUKzPTd6QCwHXomlxlRh5GcJPui0xMS0vns12rv1WsFGvRqshY0Lt/mgXEL5scg4wcAcSyvO+jB6bHNZDZwWMetwQ7v2vGtTLNQ4aLd/aUQ4UUjGzSfziZ2WvaFcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZdZ3AEE2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99D8640E021C;
	Fri,  4 Jul 2025 12:33:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EAXE6mUcVyEs; Fri,  4 Jul 2025 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751632400; bh=4rq7IYgyEa3a1mMgzYHYOEf2XgV3U52AmVcdEkY7X84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdZ3AEE2vpa3GOCQiVsW+6Oc6VJ2Ey0iab4vytbF3hWcMEKngc3Ki8TCGLKrLPmzT
	 zFQm4+/T8RCg/HQ+9vPFG44FkjKr1oxFH62M1LsuHp/DZGn0N+unTNWcqEy7zUsXEL
	 tY0QtvPkALe/j0uwobreDEsp8yMDIIQAOuSAhAHiyelXdHy8lMmGxA92xcb9rj0/N0
	 UpKy6xRv7+H6B/ZwMkPcB1Jyan1Z243keDsxA+okMxhR00G+J3zfVlZ+VvxHyRCREm
	 kheI4nXMPf/JQqpWCnpYCnKE2y6RIYtdAf7iguJIl6VYcsp2DpvlWvCC8puJbXf6rW
	 2CQ3kQUeU30BTATwi4OSnyxhtKnFXejr3MhBw3gFY4ZMxy1HaLUL6YpxQ1+Wk2quuX
	 cz7nxG/pvTvHC0jZYdfeTBYba6bugewn+Vs8Eq423Cp1iowJeMywYW9y9OA53vHBLQ
	 IPTTyxhW1h1tFyOw5Ey6uMdTsF6qrWf7fg3wcXExkDOv7AwL1gG8xgWd5J2ewXNxen
	 wTvYAUqtaxkCLULbP+iCnhIaUCCiRMTZnnq/19uES4RH/nNOZevxvVlGP6za7qx4mq
	 1heCBj9qiPEz2AThb/WH1bHo/C5XRUdREVhqh2nupl3bIJ3BhtqXOQ1vqrfdT4O4ai
	 9LOp0NpW34WlAAw1DrIBl/6A=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 266F140E00DD;
	Fri,  4 Jul 2025 12:33:12 +0000 (UTC)
Date: Fri, 4 Jul 2025 14:33:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250704123307.GCaGfKAzoceu9siXCN@fat_crate.local>
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
 <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
 <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
 <c3e97fe5-f058-4958-8660-a661f6a662a3@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3e97fe5-f058-4958-8660-a661f6a662a3@amd.com>

On Fri, Jul 04, 2025 at 05:16:44PM +0530, K Prateek Nayak wrote:
> In an attempt to solve a complicated case, I think I overlooked the
> simplest one.

It happens. No worries.

> Can you try the below incremental diff on top of this patch and

Yap, works. Thanks.

> let me know if you still hit the error:
> 
> (Lightly tested on QEMU)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 0e46068acb0a..cce540fe36c6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2423,6 +2423,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>  			struct cpumask *sd_span = sched_domain_span(sd);
>  			int id;
> +			/*
> +			 * If the child already covers the cpumap, sd
> +			 * remains un-initialized. Use sd->private to
> +			 * detect uninitialized domains.
> +			 */
> +			if (!sd->private)
> +				continue;
> +
>  			/* lowest bit set in this mask is used as a unique id */
>  			id = cpumask_first(sd_span);
> ---

Yeah, when you send a hunk I should apply, no matter how easy it is, pls send
it from a mail client which doesn't mangle the diff otherwise I get:

$ test-apply.sh -n /tmp/diff
checking file kernel/sched/topology.c
Hunk #1 FAILED at 2423.
1 out of 1 hunk FAILED

Or you can attach it.

I've done it by hand now.

> Thank you for the report and sorry for the oversight.

No worries at all.

> Hope I have not disrupted your Feierabend.

Haha, I have Feierabend a lot later, if at all :-P

I hope you can enjoy the weekend a bit and not look at code too much.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

