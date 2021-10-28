Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC343E1B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhJ1NMv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 09:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhJ1NMs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 09:12:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF966C0613B9;
        Thu, 28 Oct 2021 06:10:21 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:10:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635426619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIlmIvQakELZfqHp02Hv4QPbxYmEk9URyeqxV23u0/E=;
        b=NOKPqIUFr1MEtKiILeFcZidTReyIQHy+4jJmwgDlB26kF36MICCBnEh7ht44IMOcJoW2Gj
        05fgfkh/i3W8NjhPa7SFmYB5EUhR4KY5nuap0YDyq/oXD/5TgvYr7xCuYT70zef8IZ7TBu
        ZXtXwr+eV9D4ZObsZyEA7g816jdCwG/xTD8sya72F1oOgFILcaEPeOdwOqJyD2d7qZncPK
        EwbImYEe00RA5wGEmgqhw9sf0vMG0/7iFpZy/I9m7A1CNQ+XACxthQDB6lJdhQVHpV7pUe
        Rckp6G+pE3m6BV5mjBGhqd8vWFzQW5ooQ/TGJEN+wTLWnbB7D/kaEvEznwtd6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635426619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIlmIvQakELZfqHp02Hv4QPbxYmEk9URyeqxV23u0/E=;
        b=RTg9WvsZHLtpUhvV/yG8ZtLa7zYnJbJlWXJGrGbVpDvx+VWRdhO/Rp5Rb+Ti113tkBcV7v
        57XEdNr1/EfyXtDQ==
From:   "tip-bot2 for Stephen Rothwell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Include vmalloc.h for vzalloc()
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211025151144.552c60ca@canb.auug.org.au>
References: <20211025151144.552c60ca@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <163542661881.626.17760176511602875301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     868c250bb4639531ff33b2d879fbef39c1d9ed39
Gitweb:        https://git.kernel.org/tip/868c250bb4639531ff33b2d879fbef39c1d9ed39
Author:        Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate:    Mon, 25 Oct 2021 15:04:13 +11:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Oct 2021 14:35:27 +02:00

x86/fpu: Include vmalloc.h for vzalloc()

Explicitly include that header to avoid build errors when vzalloc()
becomes "invisible" to the compiler due to header reorganizations.

This is not a problem in the tip tree but occurred when integrating
linux-next.

 [ bp: Commit message. ]

Link: https://lore.kernel.org/r/20211025151144.552c60ca@canb.auug.org.au
Fixes: 69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 290836d..8ea306b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -16,6 +16,7 @@
 
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
+#include <linux/vmalloc.h>
 
 #include "context.h"
 #include "internal.h"
