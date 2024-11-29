Return-Path: <linux-tip-commits+bounces-2894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D79DC1FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2024 11:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4222816B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Nov 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BD167DAC;
	Fri, 29 Nov 2024 10:12:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03E914C5B0;
	Fri, 29 Nov 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875150; cv=none; b=ZpFOMpixHlPGkXRzqu1XWotaaq6ALnUMci5GxfrY2hv3qJuWufZdQpmbGWRYVWUJ4d527blwhSDhvL9rYUzESU9Itq89gQH7gtlHwZ64ZHk9794s87Nm+/Sp10V7t5uBPOAtM+coyDD6dGLQ3m5A1vogvOvEd1CQ1WmvjgxK7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875150; c=relaxed/simple;
	bh=BbfwKC/iNlnC1+UA4VuHhTiKxEtxCvZTmSnAv525mqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXJvQ/S/Nmw4owrVwMyH8RahOu+X/jOtOTt76rziQa4fwe+xELRaJZ9YECSg/g4AbAt0tJ6rX9s3t3Sy1dH1Y5Kz+84TrT+HIqYXdt/Vc0z/Y+hjZxYqSORmdTyWZOSHwhAh4S7iJWqBKm1g6XCuS0Otp01492nyx+PSgmWjatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE1A12FC;
	Fri, 29 Nov 2024 02:12:56 -0800 (PST)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674683F5A1;
	Fri, 29 Nov 2024 02:12:24 -0800 (PST)
Message-ID: <f7046fcc-91e3-434e-930c-10259b36a90b@arm.com>
Date: Fri, 29 Nov 2024 11:12:15 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>
Cc: abuehaze@amazon.com, alisaidi@amazon.com, benh@kernel.crashing.org,
 blakgeof@amazon.com, csabac@amazon.com, doebel@amazon.com,
 gautham.shenoy@amd.com, joseph.salisbury@oracle.com, kprateek.nayak@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 x86@kernel.org
References: <20241125113535.88583-1-cpru@amazon.com>
 <20241128103236.22777-1-cpru@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241128103236.22777-1-cpru@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2024 11:32, Cristian Prundeanu wrote:

[...]

> On 2024-11-26, Dietmar Eggemann wrote:
> 
>> SUT kernel arm64 (mysql-8.4.0)
>> (2) 6.12.0-rc4                -12.9%
>> (3) 6.12.0-rc4 NO_PLACE_LAG   +6.4%		
>> (4) v6.12-rc4  SCHED_BATCH    +10.8%
> 
> This is very interesting; our setups are close, yet I have not seen any 
> feature or policy combination that performs above the 6.5 CFS baseline.
> I look forward to seeing your results with the repro when it's ready.
> 
> Did you only use NO_PLACE_LAG or was it together with NO_RUN_TO_PARITY?

Only NO_PLACE_LAG.

> Was SCHED_BATCH used with the default feature set (all enabled)?

Yes.

> Which distro/version did you use for the SUT?

The default, Ubuntu 24.04 Arm64 server.

>> Maybe a difference in our test setup can explain the different test results:
>>
>> I use:
>>
>> HammerDB Load Generator <-> MySQL SUT
>> 192 VCPUs               <-> 16 VCPUs
>>
>> Virtual users: 256
>> Warehouse count: 64
>> 3 min rampup
>> 10 min test run time
>> performance data: NOPM (New Operations Per Minute)
>>
>> So I have 256 'connection' tasks running on the 16 SUT VCPUS.
> 
> My setup:
> 
> SUT     - 16 vCPUs, 32 GB RAM
> Loadgen - 64 vCPU, 128 GB RAM (anything large enough to not be a 
>  bottleneck should work)
> 
> Virtual users:  4 x vCPUs = 64
> Warehouses:     24
> Rampup:         5 min
> Test runtime:   20 min x 10 times, each on 4 different SUT/Loadgen pairs
> Value recorded: geometric_mean(NOPM)

Looks like you have 4 times less 'connection' tasks on your 16 VCPUs. So
much less concurrency/preemption ...

