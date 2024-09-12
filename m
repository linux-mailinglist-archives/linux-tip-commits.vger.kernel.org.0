Return-Path: <linux-tip-commits+bounces-2302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E01976686
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Sep 2024 12:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDF2B21069
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Sep 2024 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C219E96F;
	Thu, 12 Sep 2024 10:12:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE05A18F2CB;
	Thu, 12 Sep 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135975; cv=none; b=grDl60WWiycnrKKO2CQPpy0U2KeHHlpR0FMZccJFQTvRr/ADuNVV3pvfB/zjwIRRI/bejLVVkFm8PFkEOAFN6sGzrIWMqgMalFkgal6t2y9v72XfYAzaE5Cinc5k2SrIRc+0dV6f1uaP0iciceDDy5+vEBlbzSR81tPCwTR3Nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135975; c=relaxed/simple;
	bh=/mg9ZeJbP9TwnJEgWjRWhFyefzpUSJxPI7Q8+OV8fFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWxWUXXJ6Odtxp6Pa9XH7bBYIv0I9r/g94NQU9W9aHo4JxnKq5CTfW6RsXMP16dhJVTpn+qOwFnVfmYsfzHH4YfTon1BA/rtHCYNsLDoy+STmeLwnRmuVR4aB17fce8b81YAA/2i7FdE9JFf4hF1Tr9/HDwCH2YLxNEsB2dJqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69743DA7;
	Thu, 12 Sep 2024 03:13:22 -0700 (PDT)
Received: from [10.1.34.27] (e122027.cambridge.arm.com [10.1.34.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4787E3F73B;
	Thu, 12 Sep 2024 03:12:52 -0700 (PDT)
Message-ID: <1835eb6d-3e05-47f3-9eae-507ce165c3bf@arm.com>
Date: Thu, 12 Sep 2024 11:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: perf/core] perf: Generic hotplug support for a PMU with a
 scope
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20240802151643.1691631-2-kan.liang@linux.intel.com>
 <172596234514.2215.6662153156633974477.tip-bot2@tip-bot2>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <172596234514.2215.6662153156633974477.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 10:59, tip-bot2 for Kan Liang wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     4ba4f1afb6a9fed8ef896c2363076e36572f71da
> Gitweb:        https://git.kernel.org/tip/4ba4f1afb6a9fed8ef896c2363076e36572f71da
> Author:        Kan Liang <kan.liang@linux.intel.com>
> AuthorDate:    Fri, 02 Aug 2024 08:16:37 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 10 Sep 2024 11:44:12 +02:00
> 
> perf: Generic hotplug support for a PMU with a scope
> 
> The perf subsystem assumes that the counters of a PMU are per-CPU. So
> the user space tool reads a counter from each CPU in the system wide
> mode. However, many PMUs don't have a per-CPU counter. The counter is
> effective for a scope, e.g., a die or a socket. To address this, a
> cpumask is exposed by the kernel driver to restrict to one CPU to stand
> for a specific scope. In case the given CPU is removed,
> the hotplug support has to be implemented for each such driver.
> 
> The codes to support the cpumask and hotplug are very similar.
> - Expose a cpumask into sysfs
> - Pickup another CPU in the same scope if the given CPU is removed.
> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
> - In event init, always set the CPU in the cpumask to event->cpu
> 
> Similar duplicated codes are implemented for each such PMU driver. It
> would be good to introduce a generic infrastructure to avoid such
> duplication.
> 
> 5 popular scopes are implemented here, core, die, cluster, pkg, and
> the system-wide. The scope can be set when a PMU is registered. If so, a
> "cpumask" is automatically exposed for the PMU.
> 
> The "cpumask" is from the perf_online_<scope>_mask, which is to track
> the active CPU for each scope. They are set when the first CPU of the
> scope is online via the generic perf hotplug support. When a
> corresponding CPU is removed, the perf_online_<scope>_mask is updated
> accordingly and the PMU will be moved to a new CPU from the same scope
> if possible.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20240802151643.1691631-2-kan.liang@linux.intel.com
> ---
>  include/linux/perf_event.h |  18 ++++-
>  kernel/events/core.c       | 164 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 180 insertions(+), 2 deletions(-)
> 
[...]
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 67e115d..5ff9735 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[...]
> @@ -13856,6 +13980,42 @@ static void perf_event_exit_cpu_context(int cpu) { }
>  
>  #endif
>  
> +static void perf_event_setup_cpumask(unsigned int cpu)
> +{
> +	struct cpumask *pmu_cpumask;
> +	unsigned int scope;
> +
> +	cpumask_set_cpu(cpu, perf_online_mask);
> +
> +	/*
> +	 * Early boot stage, the cpumask hasn't been set yet.
> +	 * The perf_online_<domain>_masks includes the first CPU of each domain.
> +	 * Always uncondifionally set the boot CPU for the perf_online_<domain>_masks.
                  ^^^^^^^^^^^^^^^ typo

> +	 */
> +	if (!topology_sibling_cpumask(cpu)) {

This causes a compiler warning:

> kernel/events/core.c: In function 'perf_event_setup_cpumask':
> kernel/events/core.c:14012:13: error: the comparison will always evaluate as 'true' for the address of 'thread_sibling' will never be NULL [-Werror=address]
> 14012 |         if (!topology_sibling_cpumask(cpu)) {
>       |             ^
> In file included from ./include/linux/topology.h:30,
>                  from ./include/linux/gfp.h:8,
>                  from ./include/linux/xarray.h:16,
>                  from ./include/linux/list_lru.h:14,
>                  from ./include/linux/fs.h:13,
>                  from kernel/events/core.c:11:
> ./include/linux/arch_topology.h:78:19: note: 'thread_sibling' declared here
>    78 |         cpumask_t thread_sibling;
>       |                   ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Steve


