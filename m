Return-Path: <linux-tip-commits+bounces-2127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8F9604D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288BF1C21F3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C31991A5;
	Tue, 27 Aug 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7JnW5fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yDHclUla"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5F194AEF;
	Tue, 27 Aug 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748492; cv=none; b=gwW3dAqE5miQh3sdQhvVmgmx7ZX43As76ULDCFjvrzIoAwvvVmdqGMk39uXHjq1IEbXhSn7C1MM4lfY+urJhZSpD+xFmvdCN3piwM97COWubwrPJDPnVxzmey2YTnj/0ZMC/tMJTIV5rAWFj3Brg7y5Fb5Gudqaxv6H8OtjiGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748492; c=relaxed/simple;
	bh=TwDf773hXhfsiYVvV+dls2u7pbgcM7zdEocdZh2VUzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gW0fDDuq6dsczzXl6kEh68ZlYOGzlktu45nCCvZKFhHnmNEAgIWPdi6+vUeFOhQQnmGKYxBQ2eBPnlRaz+7LTzCPYLYA6jPluMuuUBxpP1NWNwRFJZs1cumV/Ba8jNn//zd0XeCXZwND84+VX2ziNQX0lMnCD6/4mJSkfoO951A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7JnW5fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yDHclUla; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 08:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724748486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9m7zAe/oM8NIYedLT9hEyQfOwjL4BIqPbJsnLJv+Bc=;
	b=P7JnW5fkM+2LHwb6kDXdptcVVMiWOv2CkVTKDAkQ+NG0r6YerCYj9AKC6lEw62cCV+nw7o
	2r/cxO/EUnWY6eA3VrAD67baxW2x6cyMkB5SsFm3Fzlc+c4SDIyo5Ru9HMxJGntASeRatA
	W3ovQAxR/z6CNEvZO9jydY2ovPyvjQcsqMS5mG+TTbrkWAvaJzF+NzUTAGjrsl90JEOdDY
	m1ESH1J23OYq+PJL+TmSLDsRP+19AcppdlPgRkxA9TGuJdgBT1AZoUZmZlHCFH78u/KaY+
	Guu2iWqVPOvWF7St4RpF5Cr9Q5eNifegi2iXNurnoLawLKcNXCJQ1zN/JH0neQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724748486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9m7zAe/oM8NIYedLT9hEyQfOwjL4BIqPbJsnLJv+Bc=;
	b=yDHclUlawN3VbE0zKpfq4Xfp/XlJAjNBZWeT7wBA1ZJrObYz4a5a0xbOVVTNGsiGu/OpA6
	eS7QftGg2nLG8ADA==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Ensure the SNP guest messages do not
 exceed a page
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731150811.156771-5-nikunj@amd.com>
References: <20240731150811.156771-5-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172474848574.2215.3184921045455646454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2b9ac0b84c2cae91bbaceab62df4de6d503421ec
Gitweb:        https://git.kernel.org/tip/2b9ac0b84c2cae91bbaceab62df4de6d503421ec
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 31 Jul 2024 20:37:55 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Aug 2024 10:35:38 +02:00

virt: sev-guest: Ensure the SNP guest messages do not exceed a page

Currently, struct snp_guest_msg includes a message header (96 bytes) and
a payload (4000 bytes). There is an implicit assumption here that the
SNP message header will always be 96 bytes, and with that assumption the
payload array size has been set to 4000 bytes - a magic number. If any
new member is added to the SNP message header, the SNP guest message
will span more than a page.

Instead of using a magic number for the payload, declare struct
snp_guest_msg in a way that payload plus the message header do not
exceed a page.

  [ bp: Massage. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731150811.156771-5-nikunj@amd.com
---
 arch/x86/include/asm/sev.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 79bbe2b..ee34ab0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -164,7 +164,7 @@ struct snp_guest_msg_hdr {
 
 struct snp_guest_msg {
 	struct snp_guest_msg_hdr hdr;
-	u8 payload[4000];
+	u8 payload[PAGE_SIZE - sizeof(struct snp_guest_msg_hdr)];
 } __packed;
 
 struct sev_guest_platform_data {
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 3b76cbf..89754b0 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1092,6 +1092,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	void __iomem *mapping;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct snp_guest_msg) > PAGE_SIZE);
+
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 

