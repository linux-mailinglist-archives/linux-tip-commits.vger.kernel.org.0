Return-Path: <linux-tip-commits+bounces-7403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2CCC6B785
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5D09A29D51
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F02E541F;
	Tue, 18 Nov 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfNw7QsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogp1ddTO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E0279DAD;
	Tue, 18 Nov 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494802; cv=none; b=EGgeMtOhXYTpId0HwhSci3TEoY3QOJ33B6OK+LMMc0bSolvAZuoUeYqV+tb8HrQyJEuaemsun6/0zXGW0lld/dvOZVLksn8yPtS4yRALHYUZq8k+Oa2Zyq5/H5AqAfuqW3pKD052GZO/8KycSPV3yv9FSX8Zbs80kvx9Fa43fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494802; c=relaxed/simple;
	bh=cLVPVvDgYSAHKzyplCe4JC0NGppC2om/ew4iTP+0y+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oUOH9rQCeWF14/iBMgfXLx+DLx9vxvqFEjZ6phqDVLgXkxH1J0xs1SIcu89vBoR6oTMMLAnKsz+kbO7OcSc1Ge0xNh9+L9M98788QPlOkiWnrRl36EryCHUGgIl+07j64X/DOeRcLvNOmXT8cMvbzlg8360ponMQ5Xa/glDIPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfNw7QsN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogp1ddTO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaeJx07Hrlm72DxOQuB/Ymqfw2K0gBmruXWp6dt+6aE=;
	b=KfNw7QsNt4ZyD1iANruA099oH8Lm4JEr6LSM89gPUizjBeU5iIWQU9eRe83Fv78rtO+/1z
	TIM3isuNgcyLIg+HVFn4XXg1zK2MrT5r+4gZAasRwXnPG28ZKMl4zkYWh71k/q9vLckeqh
	Xr9A51/NMRLn6NfQR3zIfRnOMoc2SR5ft5OM79xDa/565jgfnr2/FQiAHKh0aIrb1bKMB6
	yYkEGiRTKGP1Mv4mSCPE5j77cHoDOadfDF+iAZZRNveBFH7R77jIG8k6qW+z9dWggbAUkc
	pnon/+lLUDfg+cgn07wCTIfdjBQg6BCWyOgO0iEWcRyv7ZRl0LOqy+UTo1a+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaeJx07Hrlm72DxOQuB/Ymqfw2K0gBmruXWp6dt+6aE=;
	b=ogp1ddTO1D/7kqxWZmAefrhdh6MV+sAZwS9bNKcxyQ+FboDrUlSfDEuk2txJN7LzTPQN1z
	uz95rlxOqSDjBwCA==
From: "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add support for physical address valid bit
Cc: Avadhut Naik <avadhut.naik@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251118191731.181269-1-avadhut.naik@amd.com>
References: <20251118191731.181269-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349479789.498.12179863167646062865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     ab19d15bd5ee9e3a3a7f8e0ac9eb8f6eb9c0af2e
Gitweb:        https://git.kernel.org/tip/ab19d15bd5ee9e3a3a7f8e0ac9eb8f6eb9c=
0af2e
Author:        Avadhut Naik <avadhut.naik@amd.com>
AuthorDate:    Tue, 18 Nov 2025 19:15:03=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 18 Nov 2025 20:24:13 +01:00

x86/mce: Add support for physical address valid bit

Starting with Zen6, AMD's Scalable MCA systems will incorporate two new bits =
in
MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a valid System
Physical Address (SPA) is present in MCA_ADDR.

PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or if it
indicates validity of SPA in MCA_ADDR.

PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid SPA or if
it is implementation specific.

Use and prefer MCA_STATUS[PhysAddrV] when checking for a usable address.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251118191731.181269-1-avadhut.naik@amd.com
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1cfbfff..2d98886 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
=20
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
+#define MCI_STATUS_PADDRV	BIT_ULL(54)  /* Valid System Physical Address */
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exce=
ption */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
@@ -62,6 +63,7 @@
  */
 #define MCI_CONFIG_MCAX		0x1
 #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
+#define MCI_CONFIG_PADDRV	BIT_ULL(11)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
=20
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 53385e6..3f1dda3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -87,6 +87,8 @@ struct smca_bank {
 	const struct smca_hwid *hwid;
 	u32 id;			/* Value of MCA_IPID[InstanceId]. */
 	u8 sysfs_id;		/* Value used for sysfs name. */
+	u64 paddrv	:1,	/* Physical Address Valid bit in MCA_CONFIG */
+	    __reserved	:63;
 };
=20
 static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks=
);
@@ -327,6 +329,9 @@ static void smca_configure(unsigned int bank, unsigned in=
t cpu)
=20
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status =3D !!(low & BIT(8));
=20
+		if (low & MCI_CONFIG_PADDRV)
+			this_cpu_ptr(smca_banks)[bank].paddrv =3D 1;
+
 		wrmsr(smca_config, low, high);
 	}
=20
@@ -790,9 +795,9 @@ bool amd_mce_is_memory_error(struct mce *m)
 }
=20
 /*
- * AMD systems do not have an explicit indicator that the value in MCA_ADDR =
is
- * a system physical address. Therefore, individual cases need to be detecte=
d.
- * Future cases and checks will be added as needed.
+ * Some AMD systems have an explicit indicator that the value in MCA_ADDR is=
 a
+ * system physical address. Individual cases though, need to be detected for
+ * other systems. Future cases will be added as needed.
  *
  * 1) General case
  *	a) Assume address is not usable.
@@ -806,6 +811,8 @@ bool amd_mce_is_memory_error(struct mce *m)
  *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
  *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
  *	   this bit should not be checked.
+ * 4) MCI_STATUS_PADDRVAL is set
+ *	a) Will provide a valid system physical address.
  *
  * NOTE: SMCA UMC memory errors fall into case #1.
  */
@@ -819,6 +826,9 @@ bool amd_mce_usable_address(struct mce *m)
 			return false;
 	}
=20
+	if (this_cpu_ptr(smca_banks)[m->bank].paddrv)
+		return m->status & MCI_STATUS_PADDRV;
+
 	/* Check poison bit for all other bank types. */
 	if (m->status & MCI_STATUS_POISON)
 		return true;

