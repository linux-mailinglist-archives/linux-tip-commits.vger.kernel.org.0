Return-Path: <linux-tip-commits+bounces-1815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA2940B12
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665C81F21B35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287B192B74;
	Tue, 30 Jul 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iao0kUoS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960F1922FD;
	Tue, 30 Jul 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327365; cv=none; b=bCvwZrd4Pq7X26Y9syygWsV59wFwCHz14hpkzATOr3W68bE8b+JxCp3rf1UdxKvzZsflfnQbQTdm7HnTwdHFehqB/fPutHqlvUjqRaYhuNiiK9PjfYXsLUN9X5PBruQFrci49f92/RXYp4wG3bW6vJ4XjT83O4k9+P9YWu3Z5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327365; c=relaxed/simple;
	bh=8yBiPtmJEreewZxcXx2RGlFIbgv1Ei6u5QT/VaGpp20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pd2Z/KLmo3lZ5+wqNXD7Qb6f7Dz3qKVg3SNxch1TMLRWD/MYft1nzBIc2eTlUWol7eCr2wZd2vxlvzpyDYCwewRntuegneECdZyrCStTMCjXEgFdE+WNfKpKVKdfynIbbYnbhTPBF9bQwv9RW+pIiibdfqAdB9COxXO/jLeiSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iao0kUoS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8CPPH010880;
	Tue, 30 Jul 2024 08:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=aOASaCsTtRtTTdbWCoCcGvrcREE
	vjrtAGPM58cDgMsg=; b=Iao0kUoSL8ZfbmtwNNtj2YaMn4nHsj35L1o9K4xEbFp
	5Juocak6x57Mj08T59E7QJZcLcXsWd4MfN39YDNThNcea6XF6sKX93kzUfQJg6dH
	cCiRicVOCWfmnSZoCUGqLgsLwdyKt6TZgStPrheYS5rPK/B5/UA+NL6VS3qrSqkl
	Bj6r++4yT6tstP14Y9lCx9p6/ucpPgPQ5SidoNn8QLFwTT3uJBfp70wROUv7cgsy
	60xA//lHYz9Yhjee5i4zgK3pFUvcvXCSX6QG0yW0V2DP3prRZPHoVbeKJiiapTrj
	Y9U2MV/0Bl+KLj7za5zAhzBIa5Hcr4Y5iWAiNzRHkeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pnnn1b3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 08:15:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U6km77007450;
	Tue, 30 Jul 2024 08:15:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u3vgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 08:15:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U8Fkis31981836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 08:15:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5D62004B;
	Tue, 30 Jul 2024 08:15:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08DE20040;
	Tue, 30 Jul 2024 08:15:45 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.109.206.223])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jul 2024 08:15:45 +0000 (GMT)
Date: Tue, 30 Jul 2024 13:45:41 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: peterz@infradead.org
Cc: linux-tip-commits@vger.kernel.org, Zhang Qiao <zhangqiao22@huawei.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched: Initialize the vruntime of a new task
 when it is first enqueued
Message-ID: <srdvb6k4evy2dpczpzovbfb4afehbrmroutlsmids33r357azi@znkbcphlfuab>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
 <172224924797.2215.1886433124274814892.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172224924797.2215.1886433124274814892.tip-bot2@tip-bot2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v_DIBGXzROCwDtuzrdW7ZjhG1vektrHA
X-Proofpoint-GUID: v_DIBGXzROCwDtuzrdW7ZjhG1vektrHA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 adultscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054


On Mon, Jul 29, 2024 at 10:34:07AM GMT, tip-bot2 for Zhang Qiao wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> Gitweb:        https://git.kernel.org/tip/c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> Author:        Zhang Qiao <zhangqiao22@huawei.com>
> AuthorDate:    Thu, 27 Jun 2024 21:33:59 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00
> 
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20240627133359.1370598-1-zhangqiao22@huawei.com
> ---
Hi Peter,

I just noticed that my tags were not picked, just wanted to check if it's some
config issue on my end or something on the tipbot side.

Thanks,
Mukesh

