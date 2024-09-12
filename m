Return-Path: <linux-tip-commits+bounces-2303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CD976CC4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Sep 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509031C215C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Sep 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A161B1429;
	Thu, 12 Sep 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RejNEboD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A2AF07;
	Thu, 12 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152837; cv=none; b=ORtMVLxXXPek7/pHr7DBIRz6wgQbXr664AdgcXXH/IWUU/YGG5N9GZMK5lA/mmGG1nr70XMwznJ1abh4qXi2+hs/VYISCJ889ufHA059OuTN0kIZT+ZnPf+ObKpEO09/fg5U/uyehlSqpqWlhdR9AScn1y44FYPOZorScqmKHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152837; c=relaxed/simple;
	bh=mtopl/K5nIFe8atSq7wOTQN3lPmYWwufwD4mRg/IySs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxUkJh21kZhKZXOQnMX9baVfLOGQHB5RhzSNlRMk983bcPZouPKu85Bee9ni6O5FL+NY4Syww0+1CQw7JULYB2YOCQVSL6A0VTdpCvMwSGJR8/yRMmpe+YU266BdYRPTl4pdhRpVanx0H54vntW9Bmysz7hVlrXtaMkANfefTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RejNEboD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726152835; x=1757688835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtopl/K5nIFe8atSq7wOTQN3lPmYWwufwD4mRg/IySs=;
  b=RejNEboDPJ06Rap8zMeAjmstpdzNURQwfBxEQdDwVOosR3GjIZ6SlLEb
   5mTe4jtL+p+FxomPAUzWB2NEtPohyMEn4RwZhP78NePL0cXkvPItBhLID
   gUOXkqXJ77kmDVp0+niNPEiWjzDYptjaduY4S8yAf5mQD5aPwkjBvX0ug
   +t47vd9MhiDhSv1ILCkWD/NrYSz7ES1UaF/EbwmrwLR/fHuI0QNAEcuEi
   065WdcRLtu4dGIxUMENDa27Uu0eYZ5zYCriL1P9+7Snr7D32e48KIYpZG
   u5h0PsDz23FMgrjkbWRWh0YXtj8lyF0H/N0fwsBYE5+uwMF/7sTrNhfH+
   A==;
X-CSE-ConnectionGUID: Q99FVxlITgCSfvAs52idYw==
X-CSE-MsgGUID: V+bYtMmrQda5cGy+pmqMeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35602522"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35602522"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:53:24 -0700
X-CSE-ConnectionGUID: YgCBeE9LSvWZhE86IsuZsA==
X-CSE-MsgGUID: fhCIfB9GQKKaRNFps4vajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67569565"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:53:23 -0700
Received: from [10.212.20.231] (kliang2-mobl1.ccr.corp.intel.com [10.212.20.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CDDE920BF401;
	Thu, 12 Sep 2024 07:53:21 -0700 (PDT)
Message-ID: <ff48cea2-05d6-4c1a-8c0f-c3949dd294cc@linux.intel.com>
Date: Thu, 12 Sep 2024 10:53:20 -0400
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: perf/core] perf: Generic hotplug support for a PMU with a
 scope
To: Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20240802151643.1691631-2-kan.liang@linux.intel.com>
 <172596234514.2215.6662153156633974477.tip-bot2@tip-bot2>
 <1835eb6d-3e05-47f3-9eae-507ce165c3bf@arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <1835eb6d-3e05-47f3-9eae-507ce165c3bf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-12 6:12 a.m., Steven Price wrote:
> On 10/09/2024 10:59, tip-bot2 for Kan Liang wrote:
>> The following commit has been merged into the perf/core branch of tip:
>>
>> Commit-ID:     4ba4f1afb6a9fed8ef896c2363076e36572f71da
>> Gitweb:        https://git.kernel.org/tip/4ba4f1afb6a9fed8ef896c2363076e36572f71da
>> Author:        Kan Liang <kan.liang@linux.intel.com>
>> AuthorDate:    Fri, 02 Aug 2024 08:16:37 -07:00
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Tue, 10 Sep 2024 11:44:12 +02:00
>>
>> perf: Generic hotplug support for a PMU with a scope
>>
>> The perf subsystem assumes that the counters of a PMU are per-CPU. So
>> the user space tool reads a counter from each CPU in the system wide
>> mode. However, many PMUs don't have a per-CPU counter. The counter is
>> effective for a scope, e.g., a die or a socket. To address this, a
>> cpumask is exposed by the kernel driver to restrict to one CPU to stand
>> for a specific scope. In case the given CPU is removed,
>> the hotplug support has to be implemented for each such driver.
>>
>> The codes to support the cpumask and hotplug are very similar.
>> - Expose a cpumask into sysfs
>> - Pickup another CPU in the same scope if the given CPU is removed.
>> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
>> - In event init, always set the CPU in the cpumask to event->cpu
>>
>> Similar duplicated codes are implemented for each such PMU driver. It
>> would be good to introduce a generic infrastructure to avoid such
>> duplication.
>>
>> 5 popular scopes are implemented here, core, die, cluster, pkg, and
>> the system-wide. The scope can be set when a PMU is registered. If so, a
>> "cpumask" is automatically exposed for the PMU.
>>
>> The "cpumask" is from the perf_online_<scope>_mask, which is to track
>> the active CPU for each scope. They are set when the first CPU of the
>> scope is online via the generic perf hotplug support. When a
>> corresponding CPU is removed, the perf_online_<scope>_mask is updated
>> accordingly and the PMU will be moved to a new CPU from the same scope
>> if possible.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link: https://lore.kernel.org/r/20240802151643.1691631-2-kan.liang@linux.intel.com
>> ---
>>  include/linux/perf_event.h |  18 ++++-
>>  kernel/events/core.c       | 164 +++++++++++++++++++++++++++++++++++-
>>  2 files changed, 180 insertions(+), 2 deletions(-)
>>
> [...]
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 67e115d..5ff9735 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> [...]
>> @@ -13856,6 +13980,42 @@ static void perf_event_exit_cpu_context(int cpu) { }
>>  
>>  #endif
>>  
>> +static void perf_event_setup_cpumask(unsigned int cpu)
>> +{
>> +	struct cpumask *pmu_cpumask;
>> +	unsigned int scope;
>> +
>> +	cpumask_set_cpu(cpu, perf_online_mask);
>> +
>> +	/*
>> +	 * Early boot stage, the cpumask hasn't been set yet.
>> +	 * The perf_online_<domain>_masks includes the first CPU of each domain.
>> +	 * Always uncondifionally set the boot CPU for the perf_online_<domain>_masks.
>                   ^^^^^^^^^^^^^^^ typo
> 
>> +	 */
>> +	if (!topology_sibling_cpumask(cpu)) {
> 
> This causes a compiler warning:
> 
>> kernel/events/core.c: In function 'perf_event_setup_cpumask':
>> kernel/events/core.c:14012:13: error: the comparison will always evaluate as 'true' for the address of 'thread_sibling' will never be NULL [-Werror=address]
>> 14012 |         if (!topology_sibling_cpumask(cpu)) {
>>       |             ^
>> In file included from ./include/linux/topology.h:30,
>>                  from ./include/linux/gfp.h:8,
>>                  from ./include/linux/xarray.h:16,
>>                  from ./include/linux/list_lru.h:14,
>>                  from ./include/linux/fs.h:13,
>>                  from kernel/events/core.c:11:
>> ./include/linux/arch_topology.h:78:19: note: 'thread_sibling' declared here
>>    78 |         cpumask_t thread_sibling;
>>       |                   ^~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
> 

The patch to fix the warning has been posted.
https://lore.kernel.org/lkml/20240912145025.1574448-1-kan.liang@linux.intel.com/

Please give it a try.

Thanks,
Kan

