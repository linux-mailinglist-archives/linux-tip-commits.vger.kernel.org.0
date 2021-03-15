Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1333C061
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhCOPsW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9910FC0613E1;
        Mon, 15 Mar 2021 08:47:53 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w15jWxs+I9SewPIf8Ab4iTONB47vqpUHs1Fc2yaSukw=;
        b=FoewjHcxn0N4zLOFIKEGuB6ybAJXNHNng0cNbqkqHBg1uTaJIV3/iR9M1XxiH28Xqhimwu
        uSooKXtTIg4e5b6vUebhbeFYKD+KemQxcvLQSxmR3xOtKaGmx8xGmcwoU3M6jcQ35VSUMb
        IBGQGO7C3sFSlSgdjCTVMz1oHgAaxIqmKa2mUTpTqLNuCot383JuJuZ8d2aRGi5Jt734pD
        P0+gE8sW0xRYSDn8JVGzOExWJG2b94MWHiNStLg0wfiZBZwlH50uc5ot6HXPYRJur2plKP
        uEmyuaoVv5/ivQeXaRiPqbOzwrQWAkxoVesap7AvkdmdUQsGfASpUKP9oPB22A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w15jWxs+I9SewPIf8Ab4iTONB47vqpUHs1Fc2yaSukw=;
        b=J9FkBoqF/E8rO/+z+Y2eRJKDPJ8V6GAUHNgaHJtcRBhiHV9m7Awwxd3a3wA8GGpjJiPjK9
        n96XR2LpCO0odHDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn: Add @buf_len param to insn_init()
 kernel-doc comment
Cc:     Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-3-bp@alien8.de>
References: <20210304174237.31945-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326964.398.9678693893621319000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     508ef28674c1fe6ac388586cb31dc0f0bbc4172c
Gitweb:        https://git.kernel.org/tip/508ef28674c1fe6ac388586cb31dc0f0bbc4172c
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 02 Nov 2020 19:12:16 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:00:19 +01:00

x86/insn: Add @buf_len param to insn_init() kernel-doc comment

It wasn't documented so add it. No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20210304174237.31945-3-bp@alien8.de
---
 arch/x86/lib/insn.c       | 1 +
 tools/arch/x86/lib/insn.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 435630a..4d1640d 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -51,6 +51,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 3d9355e..31afbf0 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -51,6 +51,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
