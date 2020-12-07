Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68732D0FBD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Dec 2020 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgLGLxL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Dec 2020 06:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLGLxK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Dec 2020 06:53:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F9C0613D1;
        Mon,  7 Dec 2020 03:52:30 -0800 (PST)
Date:   Mon, 07 Dec 2020 11:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607341945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lLbg9HYQLDU0PQIwExP2M8i4aSkkQpCBM0/mqhPj/8=;
        b=ssRC/tfT5Gz+SygLZYrYjpCOa9la/Z32YSUCSXARBC74YjSTKqtNpKEtratP7Rs7tNmLEy
        s7t2mzwNU5XVYTvIaou8shp8lz6Ua9Pb9eeE/Gro2afpPHu6nRWTURyLkfwFmFb8IHDJ/i
        ZEpdJDG6pfD8oThacHu+a8YKO5GegZcpJGuHW8O99PLYnZFkiu7xAL4XYj6fxV1Sjfxr4U
        /rp/mcAflTFgL4ijIUPrtSJVwx+CAEmkBWtmjPj4VGnKJCOUO3DjgAt+AUcfaxuZHgy+ZX
        LNp6pDumXfoPLm1fZUmnKtc2tsNYkkJ2HyQvP8MbToeMFO3xe/eo42ivHBDLzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607341945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lLbg9HYQLDU0PQIwExP2M8i4aSkkQpCBM0/mqhPj/8=;
        b=Yu14CqfOgkgP1z3CYsrE5S16I4Zkx0jLpY/xUIL9h+UwAmeIqJlQQuC1vZJA0DgH5f5yGS
        tC5HxpLt3csnKyCg==
From:   "tip-bot2 for Qiujun Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/alternative: Update text_poke_bp() kernel-doc comment
Cc:     Qiujun Huang <hqjagain@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201203145020.2441-1-hqjagain@gmail.com>
References: <20201203145020.2441-1-hqjagain@gmail.com>
MIME-Version: 1.0
Message-ID: <160734194487.3364.10524070332719619645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     72ebb5ff806f9a421a2a53cdfe6c4ebbab243bd5
Gitweb:        https://git.kernel.org/tip/72ebb5ff806f9a421a2a53cdfe6c4ebbab243bd5
Author:        Qiujun Huang <hqjagain@gmail.com>
AuthorDate:    Thu, 03 Dec 2020 22:50:20 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Dec 2020 12:44:22 +01:00

x86/alternative: Update text_poke_bp() kernel-doc comment

Update kernel-doc parameter name after

  c3d6324f841b ("x86/alternatives: Teach text_poke_bp() to emulate instructions")

changed the last parameter from @handler to @emulate.

 [ bp: Make commit message more precise. ]

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201203145020.2441-1-hqjagain@gmail.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4adbe65..ed3efc5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1365,7 +1365,7 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * @emulate:	instruction to be emulated
  *
  * Update a single instruction with the vector in the stack, avoiding
  * dynamically allocated memory. This function should be used when it is
