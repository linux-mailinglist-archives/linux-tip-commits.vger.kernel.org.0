Return-Path: <linux-tip-commits+bounces-7369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF1C60AFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 21:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DDD0356FFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F122756A;
	Sat, 15 Nov 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LBxDVbSX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D720A5F3;
	Sat, 15 Nov 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240230; cv=none; b=Ly3QSFmiAeuLzT0ngVVmiifgq1W3q8nQebucpMgaCdaZ4gGJ/14eOvopozTV/4CoAFZ8Q0T+cWulpj0n4AHmau2r+bZ9GJsI0psJtVrdVNbkiqqhLQCPs2gTVb5OuQuVtxFBfFBefEHiHvoaCP/Spw/P0O5/9TEZbIBdkLUVSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240230; c=relaxed/simple;
	bh=MpmFhMapMByCDytr0hdiIfPDYKGjuxw2xby89ErTUDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRESiVly/w/BSXn878x1ROFeVrgZW8GDiQ+nz6Y3xiaeuOkBGJCnptS8dtok28wvk142h7U1PjHE1tBwDwupiXisNmF3IljmJsX1HKRpfKnCE6TEluWNZUYB2jKjMalQibcChcUtgAaimF3ckvUKkQ6ZE6zXFRPZE3vCJfWl6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LBxDVbSX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFKeF53020500;
	Sat, 15 Nov 2025 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eLHAz1
	a53n5VUC9XLKd/Ie1G1rAZikubGND7PiQjN5c=; b=LBxDVbSXM9lnStCoZ0N5Yn
	37FOc7VLsTiEpYzt9YJ/oknvbb44K5SOBVxzAJOq8VshyIJ46b4WCa2nSpwrVnbg
	BO1W9FB7NGUirZpONZ+Qkp4bwr64tKNFULx9tpyu3MK3uiLQ3DoNKw31BjZoEecH
	p1MedNZIYcx3mfC+XSHFWVkwbzIEmhZiPzFSFMa31P2DJp//GFXOcKrPYTtXzG3O
	PzYlTVkMX2CQG09CNIWQlRTVZFD0MKuFXezM9aQ87ZGWtC5GDziecnDQDWp9/W4e
	NVc+YwVBT3N7lNx/RFO4X0dsUbS8+ClSMth3Rv3C8UlYdBHBjodk+q8zh2htRxnw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgwhj6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Nov 2025 20:56:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFI5Tth014859;
	Sat, 15 Nov 2025 20:56:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpks08t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Nov 2025 20:56:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AFKuGY423069428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 20:56:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B291320043;
	Sat, 15 Nov 2025 20:56:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B479720040;
	Sat, 15 Nov 2025 20:56:14 +0000 (GMT)
Received: from [9.39.22.103] (unknown [9.39.22.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Nov 2025 20:56:14 +0000 (GMT)
Message-ID: <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
Date: Sun, 16 Nov 2025 02:26:13 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-tip-commits@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5esi3trVvZtoxxiaUO-av8SyQ5K7PTVp
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=6918e8f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=I1WIdZI5kOph63h-pFgA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5esi3trVvZtoxxiaUO-av8SyQ5K7PTVp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6jxq9gsyO18z
 AxRsZ9uuuUM4+/F4V4ajQDvIIivn9bygDYadpvCJbSesougM3Oi887D795GPCh7PU4r7kh0MTNq
 kXTghq0irFATjj0qqtW5ewkNRUHpKcopmktds1qTpj0wthA9p3171NN3jl9KC9Ta0AZEeNhpaaE
 /0sxFDx3O1OCA4peQENEniLKr1Qau+7m5QqQM5SZ28N0WaKAtnea1xeHLWMGtvBpPLv3LE4xUp3
 xoxso9YWXT7PWseo31Tht+wQgiJjn3w3Lot40C++bu6fT52bo2Cfnq8lyrh/uW/fsUEvRwSSSLk
 6qZoGtshYP5Cxt++l6DbRzy9X6TJ7UtXMiGxO62OEQ9/+s0gowLrimAbjcxxD8xXORAh0L5Ze3G
 2xCedBEI0T4oNbvex/kYdWVId0haUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032


Hi Peter.

On 11/14/25 5:49 PM, tip-bot2 for Tim Chen wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> Gitweb:        https://git.kernel.org/tip/2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> Author:        Tim Chen <tim.c.chen@linux.intel.com>
> AuthorDate:    Mon, 10 Nov 2025 10:47:35 -08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 14 Nov 2025 13:03:05 +01:00
> 
> sched/fair: Skip sched_balance_running cmpxchg when balance is not due
> 
> 

   
> +	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle != CPU_NEWLY_IDLE) {
> +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))

This should be atomic_cmpxchg_acquire?

I booted the system with latest sched/core and it crashes at the boot.

BUG: Kernel NULL pointer dereference on read at 0x00000000
Faulting instruction address: 0xc0000000001db57c
Oops: Kernel access of bad area, sig: 7 [#1]
LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
Modules linked in:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.18.0-rc3+ #242 PREEMPT(lazy)
NIP [c0000000001db57c] sched_balance_rq+0x560/0x92c
LR [c0000000001db198] sched_balance_rq+0x17c/0x92c
Call Trace:
[c00000111ffdfd10] [c0000000001db198] sched_balance_rq+0x17c/0x92c (unreliable)
[c00000111ffdfe50] [c0000000001dc598] sched_balance_domains+0x2c4/0x3d0
[c00000111ffdff00] [c000000000168958] handle_softirqs+0x138/0x414
[c00000111ffdffe0] [c000000000017d80] do_softirq_own_stack+0x3c/0x50
[c000000008a57a60] [c000000000168048] __irq_exit_rcu+0x18c/0x1b4
[c000000008a57a90] [c0000000001691a8] irq_exit+0x20/0x38
[c000000008a57ab0] [c000000000028c18] timer_interrupt+0x174/0x394
[c000000008a57b10] [c000000000009f8c] decrementer_common_virt+0x28c/0x290


Bisect pointed to:
git bisect bad 2265c5d4deeff3bfe4580d9ffe718fd80a414cac
# first bad commit: [2265c5d4deeff3bfe4580d9ffe718fd80a414cac] sched/fair: Skip sched_balance_running cmpxchg when balance is not due


I wondered what is really different since the tim's v4 boots fine.
There is try instead in the tip, i think that is messing it since likely
we are dereferencing 0?


With this diff it boots fine.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aaa47ece6a8e..01814b10b833 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11841,7 +11841,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
         }
  
         if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
-               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
+               if (!atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
                         goto out_balanced;
  
                 need_unlock = true;




