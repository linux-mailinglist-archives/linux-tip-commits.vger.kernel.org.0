Return-Path: <linux-tip-commits+bounces-2168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6796D25B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16F71C243AB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E719538A;
	Thu,  5 Sep 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYIdXkaD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dRPNWn/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D96194C7A;
	Thu,  5 Sep 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525519; cv=none; b=oQDxu8YYtV+TowVSfS6Ptno9BkjLMSi/YbezhLF/UhASHySU0/sc613koIjlQjJSXFhH+CtI+iueA0dRBWU1H88hqw6sM8E/IHea3qJk/olMufQy/odpeuUNiQbdz06u1qq2B7cH/dXw7FRVnGtJbN0n8xo8DoavSBrosi1eaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525519; c=relaxed/simple;
	bh=vQ4Hsg0oiJ0B+hyK+0BDm1YBzUjlrJvUooGPCzyfm54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hTIsy5twmVFSwEj6u51R89Ow7hHRZwwyFGHMblqA3mt24oc7WsHs2IDe3d8HvCUB64W+UgCFUbR1iBxknhxOHM2ApAf7IF+Yxn6gOuPeppSzHkSuZHpdvuwZ4wzz+orSK2JdWPVFxcIM814r0kIZYxEMJ9vlDULwWpBWvPvNKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYIdXkaD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dRPNWn/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 08:38:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725525516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnXq1Hg4PeqK3Q2Wbpp3WFYCFQToxdMUZb76T0Q+3oM=;
	b=IYIdXkaDCKUGNb2SS60BxQY3HbMXQpBeaELXYRQ6ObKs1orw3gxTTYh0pRBNRHvebzqzLp
	Y4rINoBgPN356glLB0IgbY/HKbew4UxbYtDNZSxr0R3R6uLVRpTHkkZhU4fgGY4tWQ0LpK
	RTLXypW0z5Vg9Va8NdzfMfclmDmkG+ebgaoHeBo+EOs75q6Hg8uP1cWc+plxxAEaB+iBU6
	0FQHNf27GfM0oieXvtrE9zD3s4e/sR6g+enB8S7GeD5S6tH2sVaaO/pjK2sfchWPCxOAY3
	CUyyNyQmW63B7uhSCAM5PfKnGnouAEEgOYL/X8fBZQyQalVQ+4DsqJmO7M3SBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725525516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnXq1Hg4PeqK3Q2Wbpp3WFYCFQToxdMUZb76T0Q+3oM=;
	b=9dRPNWn/L3bSbHyDA/BC9WbS1aLuIcPxBJaAO7FELo6X0+A7sZ93I1IIAlI7YkOo8WKeK8
	PpTWpd8CqgIbaODA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/vfm: Delete
 X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903173443.7962-3-tony.luck@intel.com>
References: <20240903173443.7962-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172552551557.2215.15519870767884928091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     13ad4848dde0f83a27d433f7e11722924de1d506
Gitweb:        https://git.kernel.org/tip/13ad4848dde0f83a27d433f7e11722924de1d506
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 03 Sep 2024 10:34:42 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 04 Sep 2024 18:05:49 +02:00

x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros

These macros have been replaced by X86_MATCH_VFM[_STEPPING]()

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240903173443.7962-3-tony.luck@intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 3831f61..e4121d9 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -193,26 +193,6 @@
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, X86_MODEL_ANY, data)
 
 /**
- * X86_MATCH_INTEL_FAM6_MODEL - Match vendor INTEL, family 6 and model
- * @model:	The model name without the INTEL_FAM6_ prefix or ANY
- *		The model name is expanded to INTEL_FAM6_@model internally
- * @data:	Driver specific data or NULL. The internal storage
- *		format is unsigned long. The supplied value, pointer
- *		etc. is casted to unsigned long internally.
- *
- * The vendor is set to INTEL, the family to 6 and all other missing
- * arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are set to wildcards.
- *
- * See X86_MATCH_VENDOR_FAM_MODEL_FEATURE() for further information.
- */
-#define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
-
-#define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-						     steppings, X86_FEATURE_ANY, data)
-
-/**
  * X86_MATCH_VFM - Match encoded vendor/family/model
  * @vfm:	Encoded 8-bits each for vendor, family, model
  * @data:	Driver specific data or NULL. The internal storage

