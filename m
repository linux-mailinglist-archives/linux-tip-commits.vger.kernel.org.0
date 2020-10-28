Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0168829DCC2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 01:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgJ1Waa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 18:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbgJ1W30 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290EC0613D3;
        Wed, 28 Oct 2020 15:29:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603894324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXxmKj+v4EMB2p2dT4DK72DXJA0Fy8oVpTc4Y0PzkWw=;
        b=iGlheWU/oN6/5nx9K0ZsRXLcUTT7v45A3vG/+dt+Bm0Q95TseVMEZ1kjv4e2i+1iUe/fNJ
        JI5Krlr41pbuFygIffjVrC3ier+xLNLq7KP2PLK3pLJsBTByj+ws8lkiT7Sv5YhT9VoQtI
        SHchE6WB/CuWi8yEh62BtWObE+scATZhi6Ym4UXKKSi6ONUuohw9fiXuJBXhgZoiEyW9UA
        4AqUJ29/tIYk/NLLNMKGJQx/s8b6WZstVMl5TvtW0hAXIJQgroiNYTHYApO05ZbSmug398
        FMrg+OZj5Sh+e13RIhVwe1kC79uK0czCrAI80sPsDQckTjNYxpFrDmrPgC1rfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603894324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXxmKj+v4EMB2p2dT4DK72DXJA0Fy8oVpTc4Y0PzkWw=;
        b=uZ4q5iEHVBTYpDytSSv2FD9qD3dWS2EZKgZtNJVAa1yGAWPBvy01fVIJET0OLpbJ02ysrN
        8nONK0mNJkVAX/Bg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Remove unused MCA variables
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201021165614.23023-1-bp@alien8.de>
References: <20201021165614.23023-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160389432296.397.3377847013706678496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0d847ce7c17613d63401ac82336ee1d5df749120
Gitweb:        https://git.kernel.org/tip/0d847ce7c17613d63401ac82336ee1d5df749120
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 21 Oct 2020 18:39:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Oct 2020 14:58:51 +01:00

x86/setup: Remove unused MCA variables

Commit

  bb8187d35f82 ("MCA: delete all remaining traces of microchannel bus support.")

removed the remaining traces of Micro Channel Architecture support but
one trace remained - three variables in setup.c which have been unused
since 2012 at least.

Drop them finally.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201021165614.23023-1-bp@alien8.de
---
 arch/x86/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84f581c..a23130c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -119,11 +119,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned int def_to_bigsmp;
 
-/* For MCA, but anyone else can use it if they want */
-unsigned int machine_id;
-unsigned int machine_submodel_id;
-unsigned int BIOS_revision;
-
 struct apm_info apm_info;
 EXPORT_SYMBOL(apm_info);
 
