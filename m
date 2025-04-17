Return-Path: <linux-tip-commits+bounces-5022-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDBA9186D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 11:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040D019E1D05
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A42226548;
	Thu, 17 Apr 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hjqT3grq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7571B4235;
	Thu, 17 Apr 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883811; cv=none; b=b5Hw54xoTeFejdIO1NMoBGi1dC1gQeAcf0+zBKIPTgGaqcYtKvB4FM+LiPmgchqkKtNR5a+S+bsi5c+QCefU80xT5oO12lKB+HGXOEft7PB5OFAUEZ+kaBK1IJlodJiQklJK6HSiL/2DRoToahqNPKQU7j1dhe8TdjxAUevABFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883811; c=relaxed/simple;
	bh=mT6LVOa9mzFBQFJx6LG8HnWWn4EPr99I7LO0DBLNeDE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=NVXU6TsmqXtCNta4vZNkkKLECidpanYMPPmA3ACydD70C3EqOCnC+xmiREHHNmTUBpF14zcsnRZ/hUK9oGYwcJkBDA3mzTvN1pAPlfmW83VLsyLS/tuQuUxfbzOsO64S4HelPe3m1k32joSNPlXqXoP+0mbE6mW58L7x6fz4wtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hjqT3grq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7wdjd015008;
	Thu, 17 Apr 2025 09:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=pp1; bh=YfEeUKlzztdFLSyNbwNx1vWoC5W0bPAHiH8t9IeH5
	Qo=; b=hjqT3grqSbdDhJXkAj7pBM6oM6GK9nJz0NN/FSG8H1aRDtNNLgAln5uvx
	Gu/9gXaswCH7ViyBYgrv19UUTFLdNZnO0rUeyb1Dcs1SAjFHvxXM1K4+2NqBh15+
	aokRrU+68+4XShHxvvnJjEdzSCsm0HAfIBvJl7clG/anJiE2/jTqJRxFQ02dsUHR
	EN8+vPVW8yJIkkqCSxOifg7w1/MXXCPkFw/uvcMZn1cLo+FRuLOnlwySwp+EP5aG
	i60Ce8MUHdmicvlvyQz2OzIU4BkN5COiEf4Tb8cf0QBQ0vAaDuwhXda7J13o+DVq
	VaOwwKuGZAPeqLylIwNqGX+tnW4Wg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7ttch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 09:56:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53H9ro2P027354;
	Thu, 17 Apr 2025 09:56:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7ttcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 09:56:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6QQNH017207;
	Thu, 17 Apr 2025 09:56:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m4y8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 09:56:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53H9uaai35127986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 09:56:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BCC520043;
	Thu, 17 Apr 2025 09:56:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 746E020040;
	Thu, 17 Apr 2025 09:56:36 +0000 (GMT)
Received: from localhost (unknown [9.152.212.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 09:56:36 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: tip-bot2@linutronix.de
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/fair: Fix EEVDF entity placement bug
 causing scheduling lag
In-Reply-To: <173642508376.399.1685643315759195867.tip-bot2@tip-bot2>
Date: Thu, 17 Apr 2025 11:56:36 +0200
Message-ID: <87zfgfi017.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ANnAolku c=1 sm=1 tr=0 ts=6800d058 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=Gf4nIRvbSLBmqkstMYUA:9
X-Proofpoint-GUID: G23CEIeI6YfLDneENfrq8rvusOdcbHCm
X-Proofpoint-ORIG-GUID: vpyBlDZ9yRCVABD1ueTtcLNzZgxHQKwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=758 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170073


Hi Peter,

after this change, we are seeing big latencies when trying to execute a
simple command per SSH on a Fedora 41 s390x remote system which is under
stress.

I was able to bisect the problem to this commit.

The problem is easy to reproduce with stress-ng executed on the remote
system which is otherwise unoccupied and concurrent SSH connect attempts
from a local system to the remote one.

stress-ng (on remote system)
----------------------------

$ cpus=$(nproc)
$ stress-ng --cpu $((cpus * 2)) --matrix 50 --mq 50 --aggressive --brk 2
            --stack 2 --bigheap 2 --userfaultfd 0 --perf -t 5m

SSH connect attempts (from local to remote system)
--------------------------------------------------

$ ssh_options=(
        -o UserKnownHostsFile=/dev/null
        -o StrictHostKeyChecking=no
        -o LogLevel=ERROR
        -o ConnectTimeout=10
        -o TCPKeepAlive=yes
        -o ServerAliveInterval=10
        -o PreferredAuthentications=publickey
        -o PubkeyAuthentication=yes
        -o BatchMode=yes
        -o ForwardX11=no
        -A
)

$ while true; do time ssh "${ssh_options[@]}" root@remote-system true; sleep 2; done

========
My tests
========

commit v6.12
------------

$ while true; do time ssh "${ssh_options[@]}" root@remote-system true; sleep 2; done

ssh "${ssh_options[@]}" ciuser@a8345039 true  0.01s user 0.00s system 1% cpu 0.919 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 9% cpu 0.068 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 8% cpu 0.069 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 6% cpu 0.092 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 6% cpu 0.097 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 5% cpu 0.109 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 7% cpu 0.083 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 7% cpu 0.079 total
ssh "${ssh_options[@]}" ciuser@a8345039 true  0.00s user 0.00s system 11% cpu 0.054 total

commit 6d71a9c6160479899ee744d2c6d6602a191deb1f
-----------------------------------------------

$ while true; do time ssh "${ssh_options[@]}" root@remote-system true; sleep 2; done

ssh "${ssh_options[@]}" ciuser@a8345034 true  0.01s user 0.00s system 0% cpu 33.379 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 0% cpu 1.206 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 0% cpu 2.388 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 9% cpu 0.055 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 0% cpu 2.376 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 2% cpu 0.243 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 11% cpu 0.049 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 0% cpu 2.563 total
ssh "${ssh_options[@]}" ciuser@a8345034 true  0.00s user 0.00s system 8% cpu 0.065 total

Thank you
Regards
Alex

