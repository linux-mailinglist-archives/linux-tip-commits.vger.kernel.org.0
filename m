Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C86436101
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJUMFO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhJUMFN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 08:05:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F8C06161C;
        Thu, 21 Oct 2021 05:02:57 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634817774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEzQQCW+N6KKP0/NFcGv8O9y0Yn/e09on+V1jdO5JWw=;
        b=bMXdAY/4T3GdZRuWjQ+1xdMzwyRq4CEY8afh29pExzUQuqcEfy2H9nPSlCjRlfvjOFdwsj
        DXJkkyOStS4m2xb3/2lvqWDvPA9zqjD4zCOhQEdMeuT8dJz29Vc1VppW/mg+3eVYHfT9sJ
        PgcNiJwQRvY3LVoHGGPXmw//kM9h3jXn5CSu/IEBLQqu+FcG7L9YONG0fCB1R7UgXVaQV8
        c6GTYYROoYGhHO+XKZcgv7BQq2VQ9NLd9zjZ+Uv/rF7KmhhwgMSC+3nAm8vXcMTZHenE5i
        ydYHiKJWqTNTSTv5+jEWMRN2vIJze+wVVE0GEVPKmSG7oREuy6vR6RFpIUPOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634817774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEzQQCW+N6KKP0/NFcGv8O9y0Yn/e09on+V1jdO5JWw=;
        b=fElGpu1vmQq8vdez3Wge1OmxJxORg6k9aImooltvujBf6ovH/RZgrcHd0oJ1jlODFkIiTB
        TIj91SoS+lwDAtDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87zgr3flq7.ffs@tglx>
References: <87zgr3flq7.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163481777358.25758.14249180150465938987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0a30896fc5025e71c350449760b240fba5581b42
Gitweb:        https://git.kernel.org/tip/0a30896fc5025e71c350449760b240fba5581b42
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 20 Oct 2021 23:08:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 13:55:42 +02:00

MAINTAINERS: Add Dave Hansen to the x86 maintainer team

Dave is already listed as x86/mm maintainer, has a profund knowledge
of the x86 architecture in general and a good taste in terms of kernel
programming in general.

Add him as a full x86 maintainer with all rights and duties.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/87zgr3flq7.ffs@tglx
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7..f26920f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20336,6 +20336,7 @@ X86 ARCHITECTURE (32-BIT AND 64-BIT)
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Borislav Petkov <bp@alien8.de>
+M:	Dave Hansen <dave.hansen@linux.intel.com>
 M:	x86@kernel.org
 R:	"H. Peter Anvin" <hpa@zytor.com>
 L:	linux-kernel@vger.kernel.org
