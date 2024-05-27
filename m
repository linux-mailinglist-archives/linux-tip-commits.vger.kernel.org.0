Return-Path: <linux-tip-commits+bounces-1292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2678CFC59
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC181F22B6C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C17D405;
	Mon, 27 May 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTDtkcCW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gh+CcFOs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2D1A2C35;
	Mon, 27 May 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800428; cv=none; b=iPT9SlDXFjEBwPbRfuRERT6g2opzX40krar3femyHvbvMqCNVK8cGkbOoH4k0j+nt0xhtZF3wr+dLFSG7au7n+31DtrYyIolfo4n8v/SXAeQXy3sUhToYlGXprWZWcwaTdF6mtiuf93/6OtnG0ELEcc/pBcPKuP1Ecx2Wxb8bbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800428; c=relaxed/simple;
	bh=i7uPmvdKsPN/ZjP/TdxT7LCJVFhNXJfXtJXDsJm6GNI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XvAoAGsVtW9inZtNxeeKDCB8ep7OmDpOcfiFP0MenpS0wlYiP37ThGNMq6FJ9PWN/+4YihYhfnopW2Qv/sP9xjinV9ViSOvokAzV0Snz9soZZJ9p8WReX5w3YxRdPYyAc0hqDDVwS4KKyaMNWHz+XULG/pFJJ7tZ/CYojDoJ+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTDtkcCW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gh+CcFOs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 09:00:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716800423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WpDwnu2zngVhRvjrCe1PCvXB9LrtyrkzfxnOUAlsKo=;
	b=iTDtkcCW8B0xQDu2Abb8Hkqr2tAsS4xyXtqv+AaOwudJXLAYpqEncK/Nxop8651ta9MtwU
	vMT2aWIyKyfdGpIHEVQV+euEnJBnRkinR08LRAqXyCwx12whi7koKngt7/Oqb/DgCe8CU3
	JUOCkb1dR7KJFMeCZx2VRN4AHTPdW3/jEcOLFXZ28r8vx44CUDPuSOOIRiL2j9o9ZMkL5w
	7PqZVu3xhufOnEBc4N9jVNfOLNZN4ov/83sW56KGrc+D/Dmh7xUjKd3GPXAur2tWOecV5f
	1TFBDDXIdP+CAn6h56IKhAFXJwPI5S+7muNTOZpyxTbbA35/tKz8+aAUcbJKPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716800423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WpDwnu2zngVhRvjrCe1PCvXB9LrtyrkzfxnOUAlsKo=;
	b=Gh+CcFOsOVjuJbxHF+Jh/9k6vrm6f8u2jfgSto17HJU9zLoXBbIboc4SSJTdLZLVIameGs
	5/aVP18mltBzxHBA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Only write MCA_MISC when a value has
 been supplied
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240523155641.2805411-2-yazen.ghannam@amd.com>
References: <20240523155641.2805411-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171680042325.10875.6859711016101123087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     ede18982f19942c7333530cf4fbf271e318df1b2
Gitweb:        https://git.kernel.org/tip/ede18982f19942c7333530cf4fbf271e318df1b2
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 23 May 2024 10:56:33 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 May 2024 10:42:35 +02:00

x86/mce/inject: Only write MCA_MISC when a value has been supplied

The MCA_MISC register is used to control the MCA thresholding feature on
AMD systems. Therefore, it is not generally part of the error state that
a user would adjust when testing non-thresholding cases.

However, MCA_MISC is unconditionally written even if a user does not
supply a value. The default value of '0' will be used and clobber the
register.

Write the MCA_MISC register only if the user has given a value for it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240523155641.2805411-2-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d7..8d18074 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -487,12 +487,16 @@ static void prepare_msrs(void *info)
 			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
+
+		if (m.misc)
+			wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 	} else {
 		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
 		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+
+		if (m.misc)
+			wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
 	}
 }
 

