Return-Path: <linux-tip-commits+bounces-4642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAEA7A3D3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A603B730F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27424EA9D;
	Thu,  3 Apr 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yaND4Ol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8PfEfAU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CC24EF95;
	Thu,  3 Apr 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687225; cv=none; b=Fh8itPfw1dkEORbOWEzBtLPgZGWKSXVI5lrmdAs/mt6w3isO4WNrj13rCRmTcyrJueRKU8RxNRyRy61Re1sicgow7XPyAToVvv5Z8vUPFUd6TEryWzavJgsfFtUVLtS5lkBxDsR43ji3gbOTMEEu5yzsPcdEPaY0mJJbKgCv7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687225; c=relaxed/simple;
	bh=jsSARuQm8IflGROVMAqCiVKEkOIThO/lxaXCONmf9k8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ipZQioroFZuH9WQmtKCcaVnNOQm2gvwaQwOHdcWa5cVeedrPj0U/MbrrESsYCLD2NULarcXCYm0SBoBEylbZs8cmkwfycKj0seEY5yLeDwlS1RvlHzft2H0OsebGYWHom8wFpJBJOk4sLsqHEEuhB1EolkZrSQ4h4EVDZ06iprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1yaND4Ol; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8PfEfAU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkxwkWn8Ymo+3Z+5PsFH2mD8rfPXHfxiGHqUk28aZ2M=;
	b=1yaND4OlcHYPLJ5JRtrIW+2nHZ4LfTCPEi3GEFKEjhVzAQNeJGWhmzywL4EKfFOVGUfLWQ
	wTTQlxs3g4AYJKBMKKNfN9kk+UyqFQTMQdOGUKUSpyoCkKEtK/Rkw5vwQrRfl396ZLa4Ak
	RUj4Joz4hFvkJzFB3nTZYXGBQFx54izUDVigJClaXLNovGtAik1C7VfHbdTvZZkgvrS+Kv
	CFiqRbOVIFCHwqv4DI68/unq1JwcjDUG2TL9B6uXG+DmYTlUKaI11au0NCMibGcrqXJSVt
	j0A4EUv+37r0aWA6YCp9sJStmaEMNnqKTNBWRPwlRTPsfYqt/khikE11x+ku9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkxwkWn8Ymo+3Z+5PsFH2mD8rfPXHfxiGHqUk28aZ2M=;
	b=S8PfEfAUEXW8B3uMOOKuzM+C2taPQMvyORWtIcH1M1xIP3EItHd2HCALgrNiEjGdrVAZyA
	B1hWZegmX0c8WRDA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Improve <asm/nmi.h> documentation
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-8-sohil.mehta@intel.com>
References: <20250327234629.3953536-8-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722009.30396.594426697810559150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     3b1292706305e5949d2aa739eb0ae009a9e6f824
Gitweb:        https://git.kernel.org/tip/3b1292706305e5949d2aa739eb0ae009a9e6f824
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:21 +02:00

x86/nmi: Improve <asm/nmi.h> documentation

NMI handlers can be registered by various subsystems, including drivers.

However, the interface for registering and unregistering such handlers
is not clearly documented. In the future, the interface may need to be
extended to identify the source of the NMI.

Add documentation to make the current API more understandable and easier
to use.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-8-sohil.mehta@intel.com
---
 arch/x86/include/asm/nmi.h | 43 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index f85aea7..79d88d1 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -20,8 +20,20 @@ extern int unknown_nmi_panic;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 
+/* NMI handler flags */
 #define NMI_FLAG_FIRST	1
 
+/**
+ * enum - NMI types.
+ * @NMI_LOCAL:    Local NMI, CPU-specific NMI generated by the Local APIC.
+ * @NMI_UNKNOWN:  Unknown NMI, the source of the NMI may not be identified.
+ * @NMI_SERR:     System Error NMI, typically triggered by PCI errors.
+ * @NMI_IO_CHECK: I/O Check NMI, related to I/O errors.
+ * @NMI_MAX:      Maximum value for NMI types.
+ *
+ * NMI types are used to categorize NMIs and to dispatch them to the
+ * appropriate handler.
+ */
 enum {
 	NMI_LOCAL=0,
 	NMI_UNKNOWN,
@@ -30,6 +42,7 @@ enum {
 	NMI_MAX
 };
 
+/* NMI handler return values */
 #define NMI_DONE	0
 #define NMI_HANDLED	1
 
@@ -43,6 +56,25 @@ struct nmiaction {
 	const char		*name;
 };
 
+/**
+ * register_nmi_handler - Register a handler for a specific NMI type
+ * @t:    NMI type (e.g. NMI_LOCAL)
+ * @fn:   The NMI handler
+ * @fg:   Flags associated with the NMI handler
+ * @n:    Name of the NMI handler
+ * @init: Optional __init* attributes for struct nmiaction
+ *
+ * Adds the provided handler to the list of handlers for the specified
+ * NMI type. Handlers flagged with NMI_FLAG_FIRST would be executed first.
+ *
+ * Sometimes the source of an NMI can't be reliably determined which
+ * results in an NMI being tagged as "unknown". Register an additional
+ * handler using the NMI type - NMI_UNKNOWN to handle such cases. The
+ * caller would get one last chance to assume responsibility for the
+ * NMI.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
 #define register_nmi_handler(t, fn, fg, n, init...)	\
 ({							\
 	static struct nmiaction init fn##_na = {	\
@@ -56,7 +88,16 @@ struct nmiaction {
 
 int __register_nmi_handler(unsigned int, struct nmiaction *);
 
-void unregister_nmi_handler(unsigned int, const char *);
+/**
+ * unregister_nmi_handler - Unregister a handler for a specific NMI type
+ * @type: NMI type (e.g. NMI_LOCAL)
+ * @name: Name of the NMI handler used during registration
+ *
+ * Removes the handler associated with the specified NMI type from the
+ * NMI handler list. The "name" is used as a lookup key to identify the
+ * handler.
+ */
+void unregister_nmi_handler(unsigned int type, const char *name);
 
 void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
 

