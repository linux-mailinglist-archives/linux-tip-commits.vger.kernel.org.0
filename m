Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA25726F83D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIRIbQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgIRIbC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:02 -0400
Date:   Fri, 18 Sep 2020 08:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/lIViaoHLNUxC0C4//BMN+h9Q6KReEAfsk7sUvBHgc=;
        b=jHBSvPZzDbjJxLOLBASg8kXYDkXAFWxjEnCh43+tiy65Z9Dqocsvli/lGDVXqliDoHP67X
        fLLcCKf3FqKv1m+xTPnwZs4uLyB6kwZwrFg/HIv5IPV8UrmNiu1+33pzGLzoEiX1wpglLO
        Y8F5A5Bj+CRypFjuGKkI76mMFDxSTLh7vroXkZx7e25Avz/Af8hsqGD09JT0j93a8eSVx9
        MFvn0QGTGp7CvpnKAcuqWE5mCrM3WyZF2Tj/7tX5kE10skn61BTIEWJ3kV2tBrKOwXmi/F
        Vl7hJrYr2V/qK7VN40DjRoyW4oEd3CAT+bqUCu7IJElUbptRE5IY85e9tUJApw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/lIViaoHLNUxC0C4//BMN+h9Q6KReEAfsk7sUvBHgc=;
        b=YRbDE3xJkaHKT/oQueyzgPQyCYTbd7pI6djw/VMvXeOgESzhTZgYlSfPpvVSdGNQYwvWhv
        JFgC912Lv4X3WBAg==
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] include: pe.h: Add RISC-V related PE definition
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415195422.19866-3-atish.patra@wdc.com>
References: <20200415195422.19866-3-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <160041785944.15536.6458913813753159065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     6d0fd536183034953bf84826fecb37e47779d24b
Gitweb:        https://git.kernel.org/tip/6d0fd536183034953bf84826fecb37e47779d24b
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Fri, 28 Aug 2020 10:20:31 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 11 Sep 2020 09:30:01 +03:00

include: pe.h: Add RISC-V related PE definition

Define RISC-V related machine types.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200415195422.19866-3-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 8ad71d7..daf09ff 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -55,6 +55,9 @@
 #define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
 #define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
 #define	IMAGE_FILE_MACHINE_R4000	0x0166
+#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
+#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
+#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
 #define	IMAGE_FILE_MACHINE_SH3		0x01a2
 #define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
 #define	IMAGE_FILE_MACHINE_SH3E		0x01a4
