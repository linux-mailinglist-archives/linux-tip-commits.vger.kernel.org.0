Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4926F3B2339
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhFWWMy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFWWMC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDDBC0611C2;
        Wed, 23 Jun 2021 15:09:12 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKXXpJAEGrTNHjGg627PoGgfppnVZbxixCPiOFYqndI=;
        b=3jVYQAv1pHQR6lS0KaVYiQvCN3b4YSNtD8R9652tvL5/x974h9XE31JsxJoh5GSNQQuWAn
        GA2RlLOE7she/dkrHVvidAG9JJ7j0gtFRQKeUdsxdxqz68Ra3A4qoyNCF/d8FXqVjXbf+y
        nuPK3xN6rp8qvjak1lEP2p7EsMoMuDEJNYpCvxxMEka2EPCfRsz8d0WbH+2Xuvn0qmhl4n
        xmfJ8IebGSKx6eR0jNBuaHfQdvZEEu/Vbk2pramOCcdy5yUv4yBB9Tn24KblkSYWXWDbNg
        ZXzTaAT1ms1jcYBCSmBPL3m7i0ekzeO6iFD/FtKsK+Z1otC2q45rrMu++Z8GVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKXXpJAEGrTNHjGg627PoGgfppnVZbxixCPiOFYqndI=;
        b=NF/u6YdVe7m0/XeALy381JHPJuQ/1ytPdWyNJ6cwljyLVya5vkWGrfUYprT1CHGyWTA8i/
        1O8ibq1+39nbsaCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkru: Provide pkru_write_default()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.513729794@linutronix.de>
References: <20210623121455.513729794@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614980.395.7631221664136842446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ff7ebff47c595e747aa1bb10d8a30b2acb7d425b
Gitweb:        https://git.kernel.org/tip/ff7ebff47c595e747aa1bb10d8a30b2acb7d425b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:09 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:09:53 +02:00

x86/pkru: Provide pkru_write_default()

Provide a simple and trivial helper which just writes the PKRU default
value without trying to fiddle with the task's xsave buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.513729794@linutronix.de
---
 arch/x86/include/asm/pkru.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 19d3d7b..7e45509 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -60,4 +60,12 @@ static inline void write_pkru(u32 pkru)
 	fpregs_unlock();
 }
 
+static inline void pkru_write_default(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	wrpkru(pkru_get_init_value());
+}
+
 #endif
