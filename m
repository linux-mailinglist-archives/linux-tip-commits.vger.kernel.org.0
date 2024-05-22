Return-Path: <linux-tip-commits+bounces-1285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B18CC48C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7B81C20A1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2A25753;
	Wed, 22 May 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dkm0Orc2"
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60710210EC
	for <linux-tip-commits@vger.kernel.org>; Wed, 22 May 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393283; cv=none; b=avkfWAfd18D5tBYjTzP21M+t9eQqGo3XsncAwIohgRIsto6DGan202n30YRE5VfLp8TsfP3HRT6/OcPARdWo/o3BDKO3QU8JonGzpyjXVdcK9KJPVoEt3BpqfwK1GYDG106rjKgBMh61iHlCrxhl1InNyvah28v/AIN+K4k4xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393283; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=DVweHNa9vJ5Zcj6G8Zq5J1YlvrDcin7L5B7CigVi/eEo2L61ZmP4XHTOX7oPi53ugZKTKXq3v/YeW+FQ3XLFvYtzGaQs69qfkCV1rCG1qCYW03mgJDFa1gKQKg9UC9Qs26blWeZ3qYX0FGiJZSgCURFaGu05xPq44TTCZdbBo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dkm0Orc2; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1716393281;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=dkm0Orc2q0+t0wW/OKOGfXDQyi8chPQpI73UWyXE48BabSfHIRpBi3BtGUgSLzLYQ
	 i4r1PR75xsUSxrDZO2h7UJXUiPJPv6PkDWYE2cTdIqtD34u3PE/snu78KYkCQFqBeh
	 kZZzlwRL6Vs68T+3+73zL4AJ/IdCJhmrOrUzhstOjeT/yIRt6u5V0FVhfEDuDA9nF+
	 KBLuIAPWWmO2p+vN9K874HXfmgHorJJ2bcRLSXWHCGvVblrt3zZmhn+nRRWR/Hhp5x
	 X6FrxsylJ9pgez0Vkj72opnQTb4kBuwUZsuuVMPcw+FSa4az3L6IP9SifSgMzgZXXw
	 lhSVMcKpf4GXg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 313C34E404AB
	for <linux-tip-commits@vger.kernel.org>; Wed, 22 May 2024 15:54:40 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: barberky859@icloud.com
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 22 May 2024 11:54:37 -0400
Subject: Kernel
Message-Id: <256C62DE-731B-4597-8CEF-717DB76DFC15@icloud.com>
To: linux-tip-commits@vger.kernel.org
X-Mailer: iPhone Mail (21F90)
X-Proofpoint-GUID: L-1t6h5GknyDJeZO4wsiHPbHYAF2CSmf
X-Proofpoint-ORIG-GUID: L-1t6h5GknyDJeZO4wsiHPbHYAF2CSmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=601 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405220108


Sent from my iPhone

