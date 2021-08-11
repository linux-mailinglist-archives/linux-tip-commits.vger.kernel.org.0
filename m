Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3F3E98F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHKTls (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhHKTls (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA87C0613D5;
        Wed, 11 Aug 2021 12:41:24 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1zsFiX6nDfZqCcRazvGkIOBDi1xpZUDS45ySvrLpoA=;
        b=aS7K7EKD2r+EC4ZTe8LOLDKd1bPCG6VOMxLuR0zhqJNvfhZo2PDwR16nRnNLSqeMYcZiKs
        tmCUDJvtKug+02wJtDJZGbHcrfuurE8svHFtjFw6h6YJOBObIYBigsOKN0UR68nrPsEDcp
        Miu4m+HAen0a0gpv5e6ifTVpdxdW5ptSPyEgds7gzcczK1t1cQTmkZXIjqxgjNQ8EHMHxh
        4+CDQUJ1xP8A/JheLjtSmYfXm7Qgz8Exv0h69+iYVJTTRIqD3QFKuP7Bb/a1TAnz5xJoDA
        Rny7Wftyh1A64D1nKRB9l4VJTjLeJS1iteETA6YqCuAjMDD/UJDPFhk4+jiFhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1zsFiX6nDfZqCcRazvGkIOBDi1xpZUDS45ySvrLpoA=;
        b=1gQ1hsrPgzvTM6dkl09Yc0/ATg1UNvNrQGuPhfmkYaXm8FnmkZc7/Ct/tX2d5A9dDLnh7f
        ZWJIJCSK4CKJhfDA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Expand resctrl_arch_update_domains()'s
 msr_param range
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-24-james.morse@arm.com>
References: <20210728170637.25610-24-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088210.395.8589186087042738185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     327364d5b6b6f8c89d2d6253a986d80323512890
Gitweb:        https://git.kernel.org/tip/327364d5b6b6f8c89d2d6253a986d80323512890
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:36 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:37:02 +02:00

x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range

resctrl_arch_update_domains() specifies the one closid that has been
modified and needs copying to the hardware.

resctrl_arch_update_domains() takes a struct rdt_resource and a closid
as arguments, but copies all the staged configurations for that closid
into the ctrl_val[] array.

resctrl_arch_update_domains() is called once per schema, but once the
resources and domains are merged, the second call of a L2CODE/L2DATA
pair will find no staged configurations, as they were previously
applied. The msr_param of the first call only has one index, so would
only have update the hardware for the last staged configuration.

To avoid a second round of IPIs when changing L2CODE and L2DATA in one
go, expand the range of the msr_param if multiple staged configurations
are found.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-24-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 92d79c8..a487cf7 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -292,6 +292,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		return -ENOMEM;
 
 	mba_sc = is_mba_sc(r);
+	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
@@ -303,9 +304,14 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
 				continue;
 
-			msr_param.low = idx;
-			msr_param.high = msr_param.low + 1;
-			msr_param.res = r;
+			if (!msr_param.res) {
+				msr_param.low = idx;
+				msr_param.high = msr_param.low + 1;
+				msr_param.res = r;
+			} else {
+				msr_param.low = min(msr_param.low, idx);
+				msr_param.high = max(msr_param.high, idx + 1);
+			}
 		}
 	}
 
