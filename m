Return-Path: <linux-tip-commits+bounces-1818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE549940E1A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243EBB26A48
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B288195398;
	Tue, 30 Jul 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o52TxW0c"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132C194140;
	Tue, 30 Jul 2024 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332560; cv=none; b=WTgJg0fovRSUZL88+wG/Q+4kUhqygsRiYS3eMGNESeYzLQCLShAqppUNq7G+gYb570NiH+sIFgzwe+My7ZpzHASfUYtYSrWHkUCu6bp/aXlPAB83V5RZAiDq2c5zQa/xhAjPDaf2vR0N7EJ6NNhXOWteozPVunf3tQPU6vrK/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332560; c=relaxed/simple;
	bh=CIKiO/0p4gU+izF/yeIUL0h8nT5GJBlgTjm+KRU5lV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rv5Qz+Nu+5VpLua0l9HNWCB5q+cFwurUxgFJzgyRua21QsgWTWYzASF/LrKue7ocVLiB40CbLohewC3Yd0uk2xNbs2ee5BVGAnZiqIHCDTEblfcHGHCvhA+KRihvvh7YrS7ITECyqpFUOcPb0kyKxVHm50BEmGe5XUAvqNE9WXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o52TxW0c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8xbjf021798;
	Tue, 30 Jul 2024 09:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=q3/7Bb1FWJrx07Ytnh6Xmm2Jmzs
	Y+rXNyAxMqmouxhE=; b=o52TxW0cTvfO0iCB96jRpxmmmgP7iYKlZgTar3kd8p5
	5hrD0f+lYAXYyDx1mWD9NuAfdN2ql6KnbQum1CaVApRbh0+czH+03PED7OK0ov8Q
	0vSL9ww7bA2Di5NcoXdpZ8pn4r2zJmOBVvS/A27e2XRTY1XHmSz7irmAnD21MaVb
	52aq3RoASgR46SaxoDx8sKX5POK9nIY2AJSqdrm5MZFqs5PcYMo+rn9bKTET3DwY
	fQEXWd7f2Gz8sHf9S4SBbAwuylRlGz8Ru8xMNf6GeV3b3YM062bxfO0pTpcKps4i
	eikR1EUtAe++LN3p5I4fTeM0mswvbMuMCPCZwIYUlrg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pw5482r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:42:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U73xnO018969;
	Tue, 30 Jul 2024 09:42:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pm02d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:42:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U9gIAt27525864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 09:42:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B67420063;
	Tue, 30 Jul 2024 09:42:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 320A02005A;
	Tue, 30 Jul 2024 09:42:17 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.109.206.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jul 2024 09:42:17 +0000 (GMT)
Date: Tue, 30 Jul 2024 15:12:14 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-tip-commits@vger.kernel.org, Zhang Qiao <zhangqiao22@huawei.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched: Initialize the vruntime of a new task
 when it is first enqueued
Message-ID: <uxlblzdkau7jtr2zzxeaz3xtmpymenqbc36mouelrg2yfyos25@mtldusftbetg>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
 <172224924797.2215.1886433124274814892.tip-bot2@tip-bot2>
 <srdvb6k4evy2dpczpzovbfb4afehbrmroutlsmids33r357azi@znkbcphlfuab>
 <20240730082815.GG33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730082815.GG33588@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WCHALlq5FA0CiCb4eNa5Wto6ZGYjjV1x
X-Proofpoint-ORIG-GUID: WCHALlq5FA0CiCb4eNa5Wto6ZGYjjV1x
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300065

On Tue, Jul 30, 2024 at 10:28:15AM GMT, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 01:45:41PM +0530, Mukesh Kumar Chaurasiya wrote:
> > 
> > On Mon, Jul 29, 2024 at 10:34:07AM GMT, tip-bot2 for Zhang Qiao wrote:
> > > The following commit has been merged into the sched/core branch of tip:
> > > 
> > > Commit-ID:     c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> > > Gitweb:        https://git.kernel.org/tip/c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
> > > Author:        Zhang Qiao <zhangqiao22@huawei.com>
> > > AuthorDate:    Thu, 27 Jun 2024 21:33:59 +08:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00
> > > 
> > > 
> > > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20240627133359.1370598-1-zhangqiao22@huawei.com
> > > ---
> > Hi Peter,
> > 
> > I just noticed that my tags were not picked, just wanted to check if it's some
> > config issue on my end or something on the tipbot side.
> 
> Could be I applied the patch before your email arrived. No harm
> intended, and I do appreciate the review effort.

Sure Peter,

Just wanted to check if i missed something.

Thanks,
Mukesh

