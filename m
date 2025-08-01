Return-Path: <linux-tip-commits+bounces-6226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C4B185F1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Aug 2025 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4561898052
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Aug 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363D1A0712;
	Fri,  1 Aug 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbUbXoog";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFiKbOZq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348823AD;
	Fri,  1 Aug 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066583; cv=none; b=MlahCx3VojvLglXAfL+t2Iz4yN/VjuNS5TRByGFcFvINth3X5iofL7IDD5ElkFZD64FW442XmktUhd4uam6+0iQoeGsplRf6JX/Nd5Ymo9V7qijy3QzyN6rcvBczsneZ5Oov+4IqUlI0YOpfb3rW1GcDcairXE0GlCZHrsZ/0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066583; c=relaxed/simple;
	bh=DGtK1iyj7wvSoVOqHvbrfVNGwmUEG/R34k7uB/IHsvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jHuucVAyZ85JX/fPBvvCHq0VkLezGKutLNMPa0I3gooC9a3m4ebdivRVzKXtRH5xZFnXDfGB6vFriRLPUJcpPwPES52qmqx7vq4/KMGoKi6TRGBOnJx7C3hc2Ap8OemLaqeLDW87nrPYiX1W2uNnMioBmNRJDKaE4QN9Cu19uyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbUbXoog; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFiKbOZq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Aug 2025 16:42:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754066577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkkdj39T+WAHHDnfSrAolZKP+9KWdnSKEIIW7bwNi1c=;
	b=dbUbXoogxiKeosOSY1fbLkA7yVQ05baCugKFWleKyCisQugbO65dLXyNuJ+cIp/5c+QwyO
	e6TJM71Y2LLNoE73iXYLcRNCrNFO9kJ/70UUN/FynYi5CMSubUSrbpeN1oTGhxt8p1hVDU
	IkDLE6NF6adOelu59iqsCS0va2uSNyaJDolzydGOxh7bHiwzFtLrErUGCJC06IoLbWflJ1
	d6RcOafMeIZP6p4ekwh2w3JN/FbxcuhqOWIpxHs/Riu72bWg3BhChZogQKbGu9mlbjxQlg
	Jp9uqtFUvMgNtsV7nEasa7bWexSuOQATKRQtq8BKOnPaziwru0lOd8WR6WtGBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754066577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkkdj39T+WAHHDnfSrAolZKP+9KWdnSKEIIW7bwNi1c=;
	b=nFiKbOZqXShqThk+Vzm5+5nkjw0xrk3h3WZE74Q+kZpMvBeM6KpmsHixwZ2o0ici2iQRiW
	8iwANGTxqa4lRCCw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add new Intel CPU model numbers for
 Wildcatlake and Novalake
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730150437.4701-1-tony.luck@intel.com>
References: <20250730150437.4701-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175406657359.1420.1839409256517255125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     49f848788a4d157bb6648a57963cb060fed3d56e
Gitweb:        https://git.kernel.org/tip/49f848788a4d157bb6648a57963cb060fed=
3d56e
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 30 Jul 2025 08:04:37 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Aug 2025 18:22:34 +02:00

x86/cpu: Add new Intel CPU model numbers for Wildcatlake and Novalake

Wildcatlake is a mobile CPU. Novalake has both desktop and mobile
versions.

  [ bp: Merge into a single patch. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250730150437.4701-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel=
-family.h
index be10c18..e345dbd 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -150,6 +150,11 @@
=20
 #define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Crestmont */
=20
+#define INTEL_WILDCATLAKE_L		IFM(6, 0xD5)
+
+#define INTEL_NOVALAKE			IFM(18, 0x01)
+#define INTEL_NOVALAKE_L		IFM(18, 0x03)
+
 /* "Small Core" Processors (Atom/E-Core) */
=20
 #define INTEL_ATOM_BONNELL		IFM(6, 0x1C) /* Diamondville, Pineview */

