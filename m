Return-Path: <linux-tip-commits+bounces-4365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5451A68ADF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D2988166F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243B25D1F7;
	Wed, 19 Mar 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AA2gJjxv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niLVAmoJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEA25C709;
	Wed, 19 Mar 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382235; cv=none; b=iiU957tMVP8Z6U5SEggipXWpisKdkEW4IHpYYOQPD7JrsIu/DMzQOe3oHndR5vWzp/Z1hce8uXLDfXXE/pBzPwbMiGXxV+auXpaCe+Qt+tRDYh0/izXGIGoZ2ldXVjW1CS1LtvUDhbYlGrsx1sj2WnZiktOmSaXDHL+yKVF5jiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382235; c=relaxed/simple;
	bh=pJM5tUAf8v9Zih5cSzMO4qOEcmBXVZ7x/FhELxbisdw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QXN8beXYmh+rXs5BfKpSG+n9ZNOkkOxvlLWVOsvhBV3gmFDssk8jqWIHtLzDvcE+23NHSvn0ZPNt5/6D/pFqIhk3XxZC/+NyQSmt2K5y+FXwpJHtl7HtVRTV5Zqgxs8FRbDTmQjRxLSu8eCapfMFJSikoUmH0YXUT3tAp4iea38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AA2gJjxv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niLVAmoJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/swzNqiTZg5KCpvmommcwcXVLChrk0HVGZmM7os4Km0=;
	b=AA2gJjxv5+U6eelznPEhukz4+CLuH7v8KWinCDwNX9lV2+sj6AU8nOPOhqnGzAUpnRimk1
	J7xE6cvj0cgbKF+5OwMZmzzchiuW2DdjLhWQb1GJWcWLSm36p9QeRKTKuGPsfBLA4jwxTj
	T6N7C8mlyyRPyNz7Et1cD2AiArwhBlwbH3QaKcR2bLpR/Lm/02oAbtbxBoW/56PjC1laRj
	l/5Xkq12lbNwCkCqHz4ADq+IvgfaSUDAY0jIkqnc03Ndh5AX/RKCOS/ytmmIjSRqqNj0g2
	fWJ/FbiK5UHldsZImsmAVGMaNeWVir/UpEFBwW50LvrAvIDnIWbHSX/Cg2PGVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/swzNqiTZg5KCpvmommcwcXVLChrk0HVGZmM7os4Km0=;
	b=niLVAmoJnJdGtVLNIwicpjTuMcy+gwkzdLuXjLCpFbRPEJswGKxufpDkdzUGfT4b3reRvH
	gkE4gtd+gvPtv1AA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/amd_node: Add a smn_read_register() helper
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217231747.1656228-2-superm1@kernel.org>
References: <20250217231747.1656228-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223147.14745.1185713088833075540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4476e7f81467b2c1b0aea7383e657181a3f9e652
Gitweb:        https://git.kernel.org/tip/4476e7f81467b2c1b0aea7383e657181a3f9e652
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 17 Feb 2025 17:17:41 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:18:48 +01:00

x86/amd_node: Add a smn_read_register() helper

Some of the ACP drivers will poll registers through SMN using
read_poll_timeout() which requires returning the result of the register read
as the argument.

Add a helper to do just that.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250217231747.1656228-2-superm1@kernel.org
---
 arch/x86/include/asm/amd_node.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 002c3af..23fe617 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -46,4 +46,15 @@ static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *val
 }
 #endif /* CONFIG_AMD_NODE */
 
+/* helper for use with read_poll_timeout */
+static inline int smn_read_register(u32 reg)
+{
+	int data, rc;
+
+	rc = amd_smn_read(0, reg, &data);
+	if (rc)
+		return rc;
+
+	return data;
+}
 #endif /*_ASM_X86_AMD_NODE_H_*/

