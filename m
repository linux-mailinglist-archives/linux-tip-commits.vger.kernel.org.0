Return-Path: <linux-tip-commits+bounces-5668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B868ABAE62
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 May 2025 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B553BD368
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 May 2025 07:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4A200BB8;
	Sun, 18 May 2025 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Na7z5a2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7L03y+3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00ED1E1C3A;
	Sun, 18 May 2025 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747551621; cv=none; b=eX3F65ujMxo/06ZONiiHdcB52pLfZ2DQLP0mWoipqzBtX9FPMYgQZ/ABTWIrayX59weWwEpxTk7riF6f8Co8NZkAqivFD1l2MYVkMvLR1wcqFIOvsFZ9pdnrL8eaa2ZVoUFS0ysXD4BQGq37iiaO+6lJ1oNV2trSmSDpUburxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747551621; c=relaxed/simple;
	bh=7YKq9SOL8Q/jFsMaOJRxgbza9s/YZJgorB1aFY2Mv2o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c8QOe4QKYdSrd9tbwTVnmPq3mf1E/EyXePePMMmGSEjM/8WbQttjXm+AM+XSIU4dRd75bbV7e8Nl4MsbTmacNI93rqwlmscTi+JQkCIVd7mKb02nPH7tVRmJr1OlQ8Wa705Qiz4qWWVzHmksKR6kKWwg99MVEwNsufK3BstZbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Na7z5a2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7L03y+3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 May 2025 06:50:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747551041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/BOEi1RBK7Qpt5A1T+o8/aU1Mmq+AdJ78Bcd5Uzyx0=;
	b=Na7z5a2vkqB/HzF7nCnNFAoqW4dtI/nENTFy8qeQOdoPugwET6x607yHmtRNGOxzqlFatH
	4rwKXs27gDhMVQje70rTwTQd8zZtSprevGTo0jA28NURrR71yJPpeBOPmDfPMrjPYp2li1
	3Cf64hweOmyYwdjBrHfj6JKnfOWNqzqhpPiqW12xrfJmJJ5L+CI6FfMI9SxKgBrn3+Q+Pi
	WK3qB+PW9fCWe9ajgAliGUw20Q09MyiXzBK7ttk1/eTZ5MlE5KNtatX0P54sMzPIpgum96
	1T226afy6BOfPOkfIN+F727y9tFXBunZC638ramGIlvFHwKK8dGPXu456LLrAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747551041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/BOEi1RBK7Qpt5A1T+o8/aU1Mmq+AdJ78Bcd5Uzyx0=;
	b=X7L03y+38M+8cFvK4OpJ5On+VjYLv97aDpmX4ML9iAI84pCDPBsSSdttPIAVZnZtVMQCoW
	7NCiv586j+BW6dBQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/msr: Remove a superfluous inclusion of <asm/asm.h>
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250512084552.1586883-2-xin@zytor.com>
References: <20250512084552.1586883-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174755104014.406.12620383027750336995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9220aa8a6779b586ef11bcd5473d103f7cf60756
Gitweb:        https://git.kernel.org/tip/9220aa8a6779b586ef11bcd5473d103f7cf60756
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 12 May 2025 01:45:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 18 May 2025 08:39:09 +02:00

x86/msr: Remove a superfluous inclusion of <asm/asm.h>

The following commit:

  efef7f184f2e ("x86/msr: Add explicit includes of <asm/msr.h>")

added a superfluous inclusion of <asm/asm.h> to

  drivers/acpi/processor_throttling.c.

Remove it.

Fixes: efef7f184f2e ("x86/msr: Add explicit includes of <asm/msr.h>")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250512084552.1586883-2-xin@zytor.com
---
 drivers/acpi/processor_throttling.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ecd7fe2..d1541a3 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -21,7 +21,6 @@
 #include <linux/uaccess.h>
 #include <acpi/processor.h>
 #include <asm/io.h>
-#include <asm/asm.h>
 #ifdef CONFIG_X86
 #include <asm/msr.h>
 #endif

