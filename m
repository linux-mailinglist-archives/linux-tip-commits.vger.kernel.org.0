Return-Path: <linux-tip-commits+bounces-1393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5409096E4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC9CB20BC4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53780BE68;
	Sat, 15 Jun 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpkXsxiI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GS/9ydLe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE41863F;
	Sat, 15 Jun 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439709; cv=none; b=NYBUKj0c3BYytISK5oRekL9wk4lmeJGWvjBksyV1Y2aRNsb4/9EdPJ0pGsGvgaA5/Acb11n7yHRj/QE2joDQIM0nRdLRy2OrVyxotDJ8Qo0Hpx8tHH+a80pwA/X0pmTIBYrzqKiP2bofxczIBdiijrLvzzro0RdcB13mrR7WVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439709; c=relaxed/simple;
	bh=Mz9eSPrWidVFSE+UPLvq6hEL3BcN3Unv9Nn1fLJu33s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kT2hF6+NOyrZ1jqhAmL6/+u5CLgMotP/kp7tznE7HMA7NxhnxGmTKl0U2QSG8/H7fT2Kc6W3iyxt0Xwh6mcquemI4Tv+Yb31byrvpX3tgm/JzxFiGQSK5W/EmNTw/sTbomGEaHkOZPLQduqz1safWWw2iUTcfqOomCOCM1dopRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpkXsxiI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GS/9ydLe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Jun 2024 08:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFgbqfbPscbmw7tKRNFDrBGsCg/ImyA9pHp1bTsybv4=;
	b=cpkXsxiIGdN5AUsJWSMijXuSeIuhbJ4COWyH8/pXxu+67boLOjFQ8c0NUGhSDL5m9RAuGO
	OZtefLXPOchn7UFeXOT5+6jdNxqi8IjWhcQp4uMTswqGMjCB2bP1yQWS/RyrQNWvRdKvAr
	LVkXDwIzTIU+RFdCetRJI5m6aPdb5g5i989HTfBnG4c5uebTUnZUbh2Q7xx3PRXrJwcYeZ
	ajKmHDAGnQifjqJj5yMwjNAVCqFhBZHLr0XM2noZ4x9gOO8OcxuJCA3QQt268y95rKBSsM
	107WbFXBZbF3UoC6UeEKxETan4s1+/I/Ku45cqiDWbZ0+M0tLOETNLSFdxxFQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFgbqfbPscbmw7tKRNFDrBGsCg/ImyA9pHp1bTsybv4=;
	b=GS/9ydLeoofXEH1ClSfKW1N0N8oQ1WvKE+OM9qldvDjOOVFy4GxODni5eptF6Biua53Yzx
	A6d1TwKLkEWsTdAQ==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Correct macro names
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171843970589.10875.891286825871783055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     ad85151d88ee6725550b856d2567bf7f3d3370e0
Gitweb:        https://git.kernel.org/tip/ad85151d88ee6725550b856d2567bf7f3d3370e0
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:48 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Jun 2024 18:01:21 +02:00

x86/vmware: Correct macro names

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.  These are
bits in the return value of the VMWARE_CMD_GETVCPU_INFO command.  Change
VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move the bit-shift
operation into the macro body.

Fixes: 4cca6ea04d31c ("x86/apic: Allow x2apic without IR on VMware platform")
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-7-alexey.makhalov@broadcom.com
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c0a3ffa..d24ba03 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -42,8 +42,8 @@
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
 
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -473,8 +473,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT

