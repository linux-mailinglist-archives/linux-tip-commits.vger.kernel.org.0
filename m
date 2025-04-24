Return-Path: <linux-tip-commits+bounces-5108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F1A9A509
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17EF189BA6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C41DCB09;
	Thu, 24 Apr 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tUgH2jbK"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910401F3BAE;
	Thu, 24 Apr 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481412; cv=none; b=hqYTBdKzXqUMI1vDrSCnwXSih1vfXjYMg+ZrxC/F3u8Eyg1r6XiSv4P4k6sCTOLx9iSqhSSUUPYw9LGFJkhfza6vzLsiInUwRpYXhF5umLi74gmPrDUF9xcFhn3k3T9Hi2Y+nMu6ZZiHeczMml49Vh/RF8BzFPhfNb5P9E4mNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481412; c=relaxed/simple;
	bh=hAuKm1I+9bS4uKJIsgbN/wyF3YH8e0P7rS8BQjfbUHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gu4bp3/wm85cmivu0OiQbaXWPlDrFgGg5O2G9BRsyaYRxU/IhLYzfD25N013YBxHKIp6P7+D33I6W+RsdYIOunrRtlOgEuHQcTFr9fqLVsfk2Mx23dVTHHIgdAxdgGGVAjCbK7poEZItEZL34QGT77Hyay2DdEk95Gb7JpPDxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tUgH2jbK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLcu9H028727;
	Thu, 24 Apr 2025 07:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hAuKm1I+9bS4uKJIsgbN/wyF3YH8e0
	P7rS8BQjfbUHU=; b=tUgH2jbKIEzFWypqV009Q4hKZborai/TY1rdXJHa0AYJz6
	szy+jWG+GltzJ1enH8S+QP2EpsHOdSd3hWk7zQgqkqv8+B9AT0yvDEmoAXuj1OCC
	RgeVV60ZxwVYW0ibHdgLLotmeTNPhO1zNRoj0xDDFkco7ChmBNf2OlyM4vv/+Oe+
	mZxZB7WyAGe+1IUX9vX0h06V9FMLcwQ/w7053z/iaDhg8NHQR4dQbaT1b6GZarC9
	kvH6y7aawgXlB9ntvt4fmMGxNQZqzHzrC/8z8bJzDYZB6CFxnoLWzVlLkJim6dHL
	cv3By371JGKxxNwNLbx+xVqCSR5iCr7bNoazrv6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aaa767-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:56:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53O7o268003808;
	Thu, 24 Apr 2025 07:56:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aaa765-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:56:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7aWL4028407;
	Thu, 24 Apr 2025 07:56:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvq5q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:56:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O7uXgS52363572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:56:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4910D2004B;
	Thu, 24 Apr 2025 07:56:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30FDD20043;
	Thu, 24 Apr 2025 07:56:33 +0000 (GMT)
Received: from localhost (unknown [9.152.212.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 07:56:33 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Doug Smythies <dsmythies@telus.net>, tip-bot2@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, x86@kernel.org,
        Doug Smythies
 <dsmythies@telus.net>
Subject: Re: ll"RE: [tip: sched/urgent] sched/fair: Fix EEVDF entity
 placement bug causing scheduling lag
In-Reply-To: <002101dbb349$03e2c7a0$0ba856e0$@telus.net>
References: <173642508376.399.1685643315759195867.tip-bot2@tip-bot2>
 <87zfgfi017.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
 <002101dbb349$03e2c7a0$0ba856e0$@telus.net>
Date: Thu, 24 Apr 2025 09:56:32 +0200
Message-ID: <87msc6dmbz.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0OSBTYWx0ZWRfX9TVgv86bNBkS IzSIlDOhPW/uzS47DTBgUSHHn++MQxojJ9nSxUgKWoA6ZF//fo7shFUcL95C8wAq54uzvcxn06N 7H7QVwWiSMh/3sq6EOCSDiVJwtGQZBDjI3iE+KKEzW2fgjbll56sszueQE/qt9H+ZJhrx0sAiWk
 J3hImtEwl3ZaGTbuc7K16M4LIcNXxtK6t2kqM5yEz/fUGScRofUKYrd3Mh6uREm+WqnE94SNU8J on+ayfOKnDUkkAbT/kIsWpeGFRBqTyjDRgW9eZyT0WXDI5T6KPNRK/E94oqVP5CXyZ7PoD8S38B YQFOG5LX2UIZo1No5Z0GnC6xb4DEEwWCrINlEk3+/vWuR/vw+mjlAuJfwEhe1krm6rmev3M3mXR
 torOC2GSw6DZGwyLCF6DxU3g2x038AJhdpIrUqLGhTPtAAHjYs7wfZ4s/jivJ9iyRH6C/1fD
X-Proofpoint-ORIG-GUID: aR2O1zCxqUdEZn86h8OZ1_3k43p-xmD6
X-Proofpoint-GUID: H7O6UEupcN4vUs8H1taYT3hJSvwpZvCr
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=6809eeb5 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=iHk1qDOP6EBl8rtHyhsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_03,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240049

Hi all,

> That is a very very stressful test. It crashes within a few seconds on my test computer,
> with a " Segmentation fault (core dumped)" message.

Yes, this is an artificial test i came up with to demonstrate the
problem we have with another realistic test which i can hardly
use here for the sake of demonstration. But it reveals the exact
same problem we have with our CI test on s390x test systems.

Let me explain shortly how it happens.

Basically, we have a test system where we execute a test suite and
simultaneously monitor this system on another system via simple SSH
logins (approximately invoked every 15 seconds) whether the test system
is still online and dump automatically if it remains unresponsive for
5m straight. We limit every such SSH login to 10 seconds because
we had situations where SSH sometimes hanged for a long time due to
various problems with networking, test system itself etc., just to make
our monitoring robust.

And since the commit "sched/fair: Fix EEVDF entity placement bug causing
scheduling lag" we regularly see SSH logins (limited to 10s) failing for
5m straight, not a single SSH login succeeds. This happens regularly
with test suites which compile software with GCC and use all CPUs
at 100%. Before the commit, a SSH login required under 1 second.
I cannot judge whether the problem really in this commit, or it is just an
accumulated effect after multiple ones.

FYI:
One such system where it happens regularly has 7 cores (5.2Ghz SMT 2x, 14 cpus)
and 8G of main memory with 20G of swap.

Thanks
Regards
Alex

