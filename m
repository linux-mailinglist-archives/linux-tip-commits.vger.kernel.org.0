Return-Path: <linux-tip-commits+bounces-2444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE899F5D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 20:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D321C232CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E4020370C;
	Tue, 15 Oct 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCLpr7FH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9hnA2yNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C1203709;
	Tue, 15 Oct 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017610; cv=none; b=NIUmsPnMGTUZCTE2NZl6MIVxeeO5Y6+HGjeWuvWcqOb/huJo3eYMIGgQ7/EG4qS1BIfauoTAaRW0vh92tHh2/EBwQUoU1XfTlvr6Vl2JcOSkYH53pJikDzl9+Vk9L/pyCk9+VkItcnL95+7pGFFYNmjV1pW2oK0pShtPryc8yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017610; c=relaxed/simple;
	bh=XhKboLW9iyqU7rF9WbsPBFtPw/DRoddFe7IEZRxnHZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FldeWo9IS0FGZKw3nNXAP3D09YXyeAvZ+nsGSp729pZS7zh2a+Vh5lG4vQgIXE2NLe/nJ8YTA0Pf/fv9tEG1LkLcKHjtdptaSRFcQx+qkjXtqFoOqzm/bNYRtDkD+EnUTXFWFPfp7C56ro/obZ3UM92a2yS3+nk98XZjT5jqvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCLpr7FH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9hnA2yNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 18:40:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729017606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmH4J6TjbgAWONfB5GdzMYuIzCSedUioCTLTyHeSSME=;
	b=LCLpr7FHxTdMUR6uv7M7qU+H9EhIPNEMg67YYdD6UNsCxKXgAgcwkfrdUFAmaeYcbgD2TK
	20doW2pd9upeaID8MnfccFueELRoRgfjSdRd6wAHP4BFuAGi7ZIUkC2nyx+405oNkGTliK
	uljDoTlxkF/P+ybIMW5+EYyjySAeCranNdxtQNdD/UScN63526ilBknoO/b98ne7IDXAGl
	aiAPEsoia3IY4bK2jft8Dr72gjBVub/T3oRxgFvnWziGvwQMxrvLsC1CvckBB+2yauh8+6
	G2bUYWemOG7ckig5L0Wqwgx5gaxfffy0P2q0bpCcX2/h5jQ3laoj7EwhJGv/fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729017606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tmH4J6TjbgAWONfB5GdzMYuIzCSedUioCTLTyHeSSME=;
	b=9hnA2yNoWenFkidugNLTn48UjmpFYBcHFdQNAmLVL3idWx4vxFOvqe35tsbOdiwyKJazaP
	Hvq/MA5dJFyxVsCw==
From: "tip-bot2 for Pavan Kumar Paluri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/virt: Provide "nosnp" boot option for sev kernel
 command line
Cc: Eric Van Tassell <Eric.VanTassell@amd.com>,
 Pavan Kumar Paluri <papaluri@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014130948.1476946-3-papaluri@amd.com>
References: <20241014130948.1476946-3-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172901760536.1442.16894857501256114810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2db67aaca578ec4998b78dc85e2af214bc2e2770
Gitweb:        https://git.kernel.org/tip/2db67aaca578ec4998b78dc85e2af214bc2e2770
Author:        Pavan Kumar Paluri <papaluri@amd.com>
AuthorDate:    Mon, 14 Oct 2024 08:09:48 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Oct 2024 20:22:18 +02:00

x86/virt: Provide "nosnp" boot option for sev kernel command line

Provide a "nosnp" kernel command line option to prevent enabling of the RMP
and SEV-SNP features in the host/hypervisor. Not initializing the RMP
removes system overhead associated with RMP checks.

  [ bp: Actually make it a HV-only cmdline option. ]

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241014130948.1476946-3-papaluri@amd.com
---
 Documentation/arch/x86/x86_64/boot-options.rst |  5 +++++
 arch/x86/virt/svm/cmdline.c                    | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 98d4805..d69e3cf 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -305,3 +305,8 @@ The available options are:
 
    debug
      Enable debug messages.
+
+   nosnp
+     Do not enable SEV-SNP (applies to host/hypervisor only). Setting
+     'nosnp' avoids the RMP check overhead in memory accesses when
+     users do not want to run SEV-SNP guests.
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index add4bae..affa275 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/printk.h>
 #include <linux/cache.h>
+#include <linux/cpufeature.h>
 
 #include <asm/sev-common.h>
 
@@ -25,6 +26,17 @@ static int __init init_sev_config(char *str)
 			continue;
 		}
 
+		if (!strcmp(s, "nosnp")) {
+			if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+				setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+				cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+				continue;
+			} else {
+				goto warn;
+			}
+		}
+
+warn:
 		pr_info("SEV command-line option '%s' was not recognized\n", s);
 	}
 

