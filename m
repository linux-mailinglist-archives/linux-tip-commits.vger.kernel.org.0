Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162DF25913C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIAOsb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgIALt0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD8C06124F;
        Tue,  1 Sep 2020 04:48:01 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myRZRXiTxqmppGavutiVaUzFQVSNFcXw9iYSyu81/9A=;
        b=uRdV/UBP4tSlTC6ipSPxaPhtmEvcSKHu0W7wxcmXyV3fI+m9b+Z3Ys1j67u/uy1+CdCrl0
        0qsOd7E0FeafX4O9Ck/rAGrpeQVVRjx8uCjSLMzDw/MWKwrx8ee2wQ2YpLA+AcB0wNufp1
        odCRuVfRy3CIoUas/1ozNmlJbONfzKTY6hBrTcveZ046km5gBhbamsxRU3fel92/qO0uRX
        IF+rDP0/nzAZdwSLnnfk6xrWKyD+jzL+kE8A4ypS4ZvkREYeUEn9lwmlA0cHMDc96O0Rb7
        +IFCpyn+5GKoSOH0tTsIEl3sxjFIJFsu/8H+cjkvBCZN3immNSm2gDpSmzJQTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myRZRXiTxqmppGavutiVaUzFQVSNFcXw9iYSyu81/9A=;
        b=WqXjuHhHg+ic1EjNb5BStncKChH/lVDgzczWf2g9IpC0GE/46S8zHK7kmuk405S3FVmYZe
        pR/77B262JU33pBQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm64/build: Add missing DWARF sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-13-keescook@chromium.org>
References: <20200821194310.3089815-13-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087708.20229.15233789093075454936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     578d7f0fd6a5ec8a369a4537c664eb2c8374c134
Gitweb:        https://git.kernel.org/tip/578d7f0fd6a5ec8a369a4537c664eb2c8374c134
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

arm64/build: Add missing DWARF sections

Explicitly include DWARF sections when they're present in the build.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-13-keescook@chromium.org
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 082e9ef..16eb2ef 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -239,6 +239,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
