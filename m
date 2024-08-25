Return-Path: <linux-tip-commits+bounces-2113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F995E3D9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E8C281715
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10A71B52;
	Sun, 25 Aug 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOrS8FRO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evLHfds2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACA29CEF;
	Sun, 25 Aug 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595691; cv=none; b=pl/LBDHqRbZpsXoLYRDnVclSuzauXSrT1teCIumu1FmehFIkz8G+3bgGxYynO3DkwQ6yYtgeioNkZe1s/1sR/UdLQoUFPP6YqOwMYWmwXZ0qzbiEyO+qoscgBn2ziG9yjmKE+inicfpoDVwLTBnIciVGbuVw+2APuJiPSgk6fkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595691; c=relaxed/simple;
	bh=CQsXH9sXE/mkkRxPRj467gnO17Ve4zWdYTdMSUFTcKk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFwiAuTGJuG90zMmgPBpEcvQMcGW6JQf/ehgvUItMnVBVLB1GzOuGaL9toh0FQmHaO/tZ8aa+LBkCC8BHFLM/AbSRLuBLrmzziIfMfzCAMIMqenBMA47Tt+CKeCbHjx1i98WSgvMq6MFu4rRrbsj4R3SJVcn3CVPMI+/SOPGS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOrS8FRO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evLHfds2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 14:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724595687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA8kS25EeYv0iXvZxcaqqq3fPQfBIsiu/6SmOIh4wbA=;
	b=yOrS8FROCJJDkwVsYEQNu1b8Y1qbWdQhgjHN86TaneKMWm6StQMyLDfb1aBit4ntxw66v/
	dmMKbJQ2TDbHPog6ytVAhuwa192w3R75SzMoMdP+dxOoK+lJxdG30d+ROhFUUo6f7OKODR
	IgVjRStMDeErSqa0V+rerfjlC1A4muTTaQWOVRccDS1SPvM46L8LXOlWvuAgBOGB//OvT3
	BJJ/2t8MHYNxB3YLSyjqCBA3J9qbXd+hiv6yxrex7Q9zhpgqv+usVKO6MfGB5408kG6Agu
	QuZFl8hzl4FfSE+knIdsSxkXU/zlN9Whab54sXBBO2cXsPgt7O9yAoaQbVSorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724595687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA8kS25EeYv0iXvZxcaqqq3fPQfBIsiu/6SmOIh4wbA=;
	b=evLHfds23W7q/ZTVrHIEgSHzVB5t91G9qqWfbiUWl4fjwblygGDCTe7NPblXjwuRmNm4eO
	yDDEr4BqRcsEHLBQ==
From: "tip-bot2 for Richard Gong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70h
Cc: Richard Gong <richard.gong@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240819123041.915734-1-richard.gong@amd.com>
References: <20240819123041.915734-1-richard.gong@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172459568697.2215.2150995323866226107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     0f70fdd42559b4eed8f74bf7389656a8ae3eb5c3
Gitweb:        https://git.kernel.org/tip/0f70fdd42559b4eed8f74bf7389656a8ae3eb5c3
Author:        Richard Gong <richard.gong@amd.com>
AuthorDate:    Mon, 19 Aug 2024 07:30:41 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 16:10:41 +02:00

x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70h

Add new PCI IDs for Device 18h and Function 4 to enable the amd_atl driver
on those systems.

Signed-off-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/all/20240819123041.915734-1-richard.gong@amd.com

---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 61eadde..dc5d321 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -44,6 +44,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
+#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 #define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
@@ -125,6 +127,8 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}

