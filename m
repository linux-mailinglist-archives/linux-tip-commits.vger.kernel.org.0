Return-Path: <linux-tip-commits+bounces-6373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67BB34E6D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 23:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C765E188EF41
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBB728C841;
	Mon, 25 Aug 2025 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="U+PtCb9X"
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0528D8CE
	for <linux-tip-commits@vger.kernel.org>; Mon, 25 Aug 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158686; cv=none; b=G29XaIznd0Mcal71mI+5/tKzn3S5RRpRblBZQT1WhL04erj7nbpvE5YQMfZHh1HKLPW+IhLbYu/vO09lYYDG/Eg4fI4M69NnHGR7yjimu222bHfNrAKJe6m4x6EB+jSmy6g2iycgo2LsmYaHUufsvw2rJDNnBnMaIi0Txwpe7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158686; c=relaxed/simple;
	bh=Z1MdS5Urfw7ePm/p1D4MrWWCnqc/pjXbcAkk0qAPJOI=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=UOsRf/e7ouoy9N06ZPrNQFw88XY12VlYoNNtUvEsh5w9DgR+iXA75le+BxrNHklgz+4hpmlaKLlZIS+xW6SBAes7aA/0ECyRnYaG9wYWEzxVtHQVNG2vXPn13LoKUj7QSOafyTPl5e1kjPy+PxFpqd2G0nIPZl+QtO5tN5ucb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=U+PtCb9X; arc=none smtp.client-ip=210.65.1.144
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLpLUg594846
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-tip-commits@vger.kernel.org>; Tue, 26 Aug 2025 05:51:21 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1756158681; bh=JBCbLQYoCHeAvUijnyWJT+nTyyE=;
	h=From:To:Subject:Date;
	b=U+PtCb9XJixmWH3VjHeUwEOpr72H8XWHh/CmV2yQ38NkpdwfEklUsp0+03ARsz1i+
	 a0ZjELoqHu5P2Cjx5mCr0o16YnGUJjHcvYYocjnP6Ht9J1neW7g0rDWZR/24VX9nib
	 tLtnkbvjVA4Hr/u8KnQJmSNCL10RxitKalLZ50wQ=
Received: from [127.0.0.1] (125-230-5-136.dynamic-ip.hinet.net [125.230.5.136])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLnYGD950305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-tip-commits@vger.kernel.org>; Tue, 26 Aug 2025 05:49:37 +0800
Message-ID: <60914013f4dade5a4ac9c81ff297e73a85dc037579b5237e3e700443cca6156b@msa.hinet.net>
From: Sales <europe-salesclue@msa.hinet.net>
Reply-To: europe-sales@albinayah-group.com
To: linux-tip-commits@vger.kernel.org
Subject: September Quote - RFQ
Date: Mon, 25 Aug 2025 14:49:36 -0700
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AKpXSxtd c=1 sm=1 tr=0 ts=68acda72
	a=oN9o3Mm1BgJ1Eb5ndfgPWw==:117 a=kj9zAlcOel0A:10 a=OrFXhexWvejrBOeqCD4A:9
	a=CjuIK1q_8ugA:10

Hi,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

