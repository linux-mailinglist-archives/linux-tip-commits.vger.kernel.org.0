Return-Path: <linux-tip-commits+bounces-6400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2AB3FCA8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BA17A29A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFB62EC0BE;
	Tue,  2 Sep 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8uPo4Ao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+o0a0kq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF802EACE9;
	Tue,  2 Sep 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809396; cv=none; b=UG16M9Qyk60//5Xkl+dDPiAoWkLVOKCNOOB8/M+Fx0RLC7Bka2OnhvQ/+g8ODpl6fuOfsygyFw9prlLfndg1BqTxenxCHLpGyR/6mEwsDxxTUvuyUmys+tLQALrSvUMrI50XuJcTqqb5KeHeVcgF0VWZMu2GsUEYidtLlqp/boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809396; c=relaxed/simple;
	bh=hnGuhjgUz225D9L2q0G9NvO775sYPd8C7IRE+jfRI1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UY3UXx9VE21UFbJBNktFAShjbtulVxDxtIgupjxPrf3BowyovhWm3j0/5Eiiv69/AteXUqJr6t9BBkTdfDckJ5mgYZqEp0IFtCB4gvOgBSMGW3huKJQ7NKhcM/UYCukwJxVwKTdbCuhaDsvUrX5kKt4W2gq0+ji6mTvwkrxYFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8uPo4Ao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+o0a0kq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVIiACTdUPr3CFAsdy+NWtS0LJSiR9yRVGrtz58w5No=;
	b=s8uPo4Ao/B1yOBfDqbwyhOMguxM8JwAJTg0XQR/5qbesbmnv6vhDJD31FP+WzVOGocQFsr
	+DT5uTuYuCdwhqyvWbjrkWEMak4/uC9P3AO78olp38GRz1brIo302quqeMTXfA1V4DeUxy
	QkD+fQAy0EKxkTxjLmVMVs8h+DsTcQhqxBu/QBmdb2c1Nm3ZWqxTi/rX8Pbtnd73HnFcEm
	J0WoMhDUxJF4jdiD89AxIgkZ7wevN4qoWj5pCBf/XPTsP+PHnznHTH84JVfHVE4XwRn/Yz
	hETRbtlbYOzNNEW91ehU3QDSsonep/ZxoDfEA9/2K3fMKN9xsogk9xSTpHCBVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVIiACTdUPr3CFAsdy+NWtS0LJSiR9yRVGrtz58w5No=;
	b=y+o0a0kqzIqvk8XAjfnjalQ9osuP4TZnOKKiHM5Lnq/86ZTFnh6r8rftsWHyIi1Shdf6aG
	o6Jp1pu+63MbXKDg==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/sev: Indicate the SEV-SNP guest supports Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828113225.209174-1-Neeraj.Upadhyay@amd.com>
References: <20250828113225.209174-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939099.1920.716710287122637116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     27a17e02418e978198513edfb389b65237f4eaf5
Gitweb:        https://git.kernel.org/tip/27a17e02418e978198513edfb389b65237f=
4eaf5
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 17:02:24 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:20:53 +02:00

x86/sev: Indicate the SEV-SNP guest supports Secure AVIC

Now that Secure AVIC support is complete, make it part of to the SNP present
features.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828113225.209174-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/boot/compressed/sev.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 74e083f..048d3e8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -238,13 +238,20 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 				 MSR_AMD64_SNP_SECURE_AVIC |		\
 				 MSR_AMD64_SNP_RESERVED_MASK)
=20
+#ifdef CONFIG_AMD_SECURE_AVIC
+#define SNP_FEATURE_SECURE_AVIC		MSR_AMD64_SNP_SECURE_AVIC
+#else
+#define SNP_FEATURE_SECURE_AVIC		0
+#endif
+
 /*
  * SNP_FEATURES_PRESENT is the mask of SNP features that are implemented
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
 #define SNP_FEATURES_PRESENT	(MSR_AMD64_SNP_DEBUG_SWAP |	\
-				 MSR_AMD64_SNP_SECURE_TSC)
+				 MSR_AMD64_SNP_SECURE_TSC |	\
+				 SNP_FEATURE_SECURE_AVIC)
=20
 u64 snp_get_unsupported_features(u64 status)
 {

