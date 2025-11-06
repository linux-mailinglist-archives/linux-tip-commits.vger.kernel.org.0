Return-Path: <linux-tip-commits+bounces-7275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD8C3C0FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25D95620F6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76719274B46;
	Thu,  6 Nov 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFLLyEMk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541D285072;
	Thu,  6 Nov 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442791; cv=none; b=GHItUvEVm9AZh2myvg+QHltbsdYQptvLXP9fdumsE7mSi5os0qyUkhDKVo6IfQ/UZVVl1Z2xybTNuXYrw84JLrzlWxpsXxPkpW6Qvjzfn5Z0Po6HFgpptfZnd0sXUqYuTSxRFoDZD8l3mceYXptmbJvVqQ8E+aKWG/c8vPZPsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442791; c=relaxed/simple;
	bh=XTv5CtKyw5T+cikM3lChb6I+ifzHbqbEPXXWWZ1P03I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlO4LClcuKsKodQYE481o9RCxtwBAQRRCrM30KwQguKNmbj7lGJ1hFCy81K7ixoSXWbYzQ+cKR21Vy20Pbqvj/fdrTCvcvO8cBcpMnR6wcZf/1KfCvcMyb3Sh/ygLbxFyzq5eNEnhsCyZrir8VyfLhLhL9mXtb9R9YjqjcFUpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AFLLyEMk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6DrgRw028886;
	Thu, 6 Nov 2025 15:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1dpS68
	wJX7ETXG0/qSQp8PA+Kt9jad3I2pDXQQhx8vE=; b=AFLLyEMkuhPQmerJWqgzGg
	5YgoAp25PUGXTHmKh0QNIyxxY7cndhjHAZNp2ChwJBV3AP/ycwn5SdCAUQIeO2NZ
	B99cGEn6uXU8a27GCe2sFL7BnufOJsISC+7dqlvSNv2XS69PdK5WCKpD+3ZZTAmT
	Eq2OQVMtfAC4+l3J49ITfnQIx6zof93sYI3e7dAt5Z5/DZB56mOhTghgajA19CO2
	Ps497lB378Nv2W/hCTSpr9QkGWLrtbTFHgSKk89828VgCEi51KueeC3ZZaDjSnqI
	WEiYvrZZpaRxlSPp0pZw2oL4aEVhQ+7ViVropNoM+HLbj1er4DhryrAJjHMsVtIg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q97ybc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 15:26:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EhAhP025556;
	Thu, 6 Nov 2025 15:26:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsxakj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 15:26:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6FQDGE39321996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 15:26:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63BAF2004E;
	Thu,  6 Nov 2025 15:26:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29FB920040;
	Thu,  6 Nov 2025 15:26:12 +0000 (GMT)
Received: from [9.39.31.151] (unknown [9.39.31.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 15:26:11 +0000 (GMT)
Message-ID: <5cf46757-6029-4ea6-9006-5dc36b00e664@linux.ibm.com>
Date: Thu, 6 Nov 2025 20:56:11 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: locking/urgent] futex: Optimize per-cpu reference counting
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
References: <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
 <176242925149.2601451.16934943329668653196.tip-bot2@tip-bot2>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <176242925149.2601451.16934943329668653196.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690cbe18 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=BYWC0JrQTQFL7lp5G-AA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: h9gyzSmNBu3FSffTICO9Fc45vKd0khd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX5kbiXUPHPK0A
 AbFnmADHnEYZ5H+7zivI8kmHI75w+xIHP9tyjJLvm9SYnvgqv8CvKEF0rYinH45a//DprfUIheC
 S0CrSfshlUd8aiJHOtnp+je/clXiAWC5ywPAzV5IlQ1NrN4klfDcHL7jbcOQAwZ1o3ZoR8ltUZK
 TRn21wCGCKXpby624ULiK4hsCj6+pNRuleKwRHWtA1GdTDvlMhaePVh2b1QJSA2RZCUWpLY6ZUN
 I4ra0dx42p2M+c0OsxbMAznrH654lWqo2PQ0B7XkxNKri34iEtY1aReVxpVlA1sprK8gnlRFTj3
 04RO7I2wX1igQmSjncrlfGkAFoaGM3D8WafFSfVUSFG9JyNOdP9b3IB9tgz9JRCG24V0+VmBIXP
 A9AGrrBS9KMzgD00N79t1bbj87etNg==
X-Proofpoint-GUID: h9gyzSmNBu3FSffTICO9Fc45vKd0khd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018



On 11/6/25 5:10 PM, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the locking/urgent branch of tip:
> 
> Commit-ID:     4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d
> Gitweb:        https://git.kernel.org/tip/4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 16 Jul 2025 16:29:46 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 06 Nov 2025 12:30:54 +01:00
> 
> futex: Optimize per-cpu reference counting
> 
> Shrikanth noted that the per-cpu reference counter was still some 10%
> slower than the old immutable option (which removes the reference
> counting entirely).
> 

Thanks for picking it up.

