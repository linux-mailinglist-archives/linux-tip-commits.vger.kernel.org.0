Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAC2CA579
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgLAOWc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 09:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLAOWb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 09:22:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E6C0613CF;
        Tue,  1 Dec 2020 06:21:51 -0800 (PST)
Date:   Tue, 01 Dec 2020 14:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606832509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXR2UCXgzQJckdE1VjLynnNMuNCrAjZe3ReBI7ONfjM=;
        b=0F54uI299Wn5CD+3YVkaqahRqI/LTDvbge7g1a3wHCc5LOuiYz+wIxKu+cIIN24vnENmV1
        Ax7p2+WcsJ5/6HpF5c5TR0inqXgnf5saVFw1iMBNjOLAotq5kkfjyrUOvD1bL+PFC4epDA
        TYIuMBKBtxaVAy4HcKXA8D/ggBbejfpDebNJSOCtYAyEUZLXlLRs/Lox2Q9yBV8VWoz769
        NOez38zyNHVHvsSs4VQu3AVCN5g0hpsMMcioor389QyEJs4GIb9dk9SIcViCJpPSPP6ws7
        2gXAfZSxx4Pe8E5PNChpLWUj4r4VRXU6lGibkAsoCHRw1T5cHU2mO8/Fd0D7OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606832509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXR2UCXgzQJckdE1VjLynnNMuNCrAjZe3ReBI7ONfjM=;
        b=QPXYU2B8zCK/T+eeU+rY+CgZRk4QgLcDI0DyzQpdIC6oA05zuUWdmfi13vteaTiSWOnvu6
        X21Av8eN1aGpcmDQ==
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/pci: Fix the function type for check_reserved_t
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130193900.456726-1-samitolvanen@google.com>
References: <20201130193900.456726-1-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <160683250909.3364.11212976072626111571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     83321c335dccba262a57378361d63da96b8166d6
Gitweb:        https://git.kernel.org/tip/83321c335dccba262a57378361d63da96b8166d6
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Mon, 30 Nov 2020 11:39:00 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 14:22:52 +01:00

x86/pci: Fix the function type for check_reserved_t

e820__mapped_all() is passed as a callback to is_mmconf_reserved(),
which expects a function of type:

  typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);

However, e820__mapped_all() accepts enum e820_type as the last argument
and this type mismatch trips indirect call checking with Clang's
Control-Flow Integrity (CFI).

As is_mmconf_reserved() only passes enum e820_type values for the
type argument, change the typedef and the unused type argument in
is_acpi_reserved() to enum e820_type to fix the type mismatch.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201130193900.456726-1-samitolvanen@google.com
---
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 6fa42e9..234998f 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -425,7 +425,7 @@ static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 {
 	struct resource mcfg_res;
 
@@ -442,7 +442,7 @@ static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 	return mcfg_res.flags;
 }
 
-typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
+typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				     struct pci_mmcfg_region *cfg,
