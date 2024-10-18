Return-Path: <linux-tip-commits+bounces-2518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BD9A3A8C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 11:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015321C20A34
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C79200CA2;
	Fri, 18 Oct 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WK6h/5tV"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B5200CB4;
	Fri, 18 Oct 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245278; cv=none; b=O/EOnaKauK8PDkPjaH96WpP/YUIEkWPRjg2LaLaRZvWu1+cTyLqsfwAkHu5PozCmqiymrIz/xFUhqcuR2CVhjO6sE1ybeKLNxaPYEBlzofrpiEICm5rJh1Uk8VCbFmWc3Sdkt5S0A2Xie1RCaRYkSZhXMmCQD69p3Ha3LIYIIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245278; c=relaxed/simple;
	bh=TvnoTTRhmWEdm4EKU+Bod3Liuxl2TsfTwJ29DhNOaLY=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VOppINJDoJkPmhchFgUJP7vQrakSgYdwqeSPldZLq1QOWRPA4CALSVCEQxxQOJml/rJumCyYWBYUFH3m4XSInX7Db9C4oBikCoCSs+90sdtu2TOA+ampTaVTLtjJQkiqfhoTwlVBn6ImhygeD8GerG2t3hgUNo2VdHQ5Dre8Dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WK6h/5tV; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729245277; x=1760781277;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=iXSmeheKIAOLwXx9bM6D0zvFWASH0Zm7l/lL/GdVuS4=;
  b=WK6h/5tVhVQUpCeh4FPiWuDq3oYShrcmzUrmbe1H85J1yMijFmMzWS1K
   TEHm65+xGed6fcJToTl8UfPE6kMG510uwDned/nIVmkf1sFpq5/OizIe6
   7yjNYNkyvJ2mjVIk0Jopwlqys8Ritc3pjsE8AgZuVWcDaLqmOYRbKFPdg
   U=;
X-IronPort-AV: E=Sophos;i="6.11,213,1725321600"; 
   d="scan'208";a="436141146"
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY
 and move them to sysctl
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 09:54:33 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:35414]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.49:2525] with esmtp (Farcaster)
 id 33701318-bce5-4192-970c-29155082d837; Fri, 18 Oct 2024 09:54:30 +0000 (UTC)
X-Farcaster-Flow-ID: 33701318-bce5-4192-970c-29155082d837
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 09:54:30 +0000
Received: from [192.168.198.222] (10.106.83.41) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 09:54:30 +0000
Message-ID: <cb7be27b-8063-4eba-98b7-3672c8c41b96@amazon.com>
Date: Fri, 18 Oct 2024 10:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Prundeanu, Cristian" <cpru@amazon.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Doebel, Bjoern" <doebel@amazon.de>,
	"Blake, Geoff" <blakgeof@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Csoma, Csaba" <csabac@amazon.com>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>
References: <20241017052000.99200-1-cpru@amazon.com>
 <20241017091036.GT16066@noisy.programming.kicks-ass.net>
 <70D6B66E-B4BC-4A92-9A23-0DADE9B8C3FE@amazon.com>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <70D6B66E-B4BC-4A92-9A23-0DADE9B8C3FE@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D004EUA004.ant.amazon.com (10.252.50.183) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

>> And sysctl is arguably more of an ABI than debugfs, which
>> doesn't really sound suitable for workaround.
>>
>> And I don't see how adding a line to /etc/rc.local is harder than adding
>> a line to /etc/sysctl.conf
> 
> Adding a line is equally difficult both ways, you're right. But aren't
> most distros better equipped to manage (persist, modify, automate) sysctl
> parameters in a standardized manner?
> Whereas rc.local seems more "individual need / edge case" oriented. For
> instance: changes are done by editing the file, which is poorly scriptable
> (unlike the sysctl command, which is a unified interface that reconciles
> changes); the load order is also typically late in the boot stage, making
> it not an ideal place for settings that affect system processes.
> 

I'd add to what Cristian mentioned is that having these tunables as 
sysctls will make them more detectable to the end users because checking 
output of sysctl -a is usually one of the first steps during performance 
troubleshooting vs checking /sys/kernel/debug/sched/ files so it's 
easier for people to spot these configurations as sysctls if they notice 
performance difference after upgrading the kernel.

Hazem

