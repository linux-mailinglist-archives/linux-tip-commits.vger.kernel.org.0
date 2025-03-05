Return-Path: <linux-tip-commits+bounces-4006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D7A4FD4C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 12:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DBB18855E4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BC230BC6;
	Wed,  5 Mar 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="USVcAcsv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGhzJ6CJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE920469F;
	Wed,  5 Mar 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173107; cv=none; b=Dt/CQBif28GGtuzF08hD/YkJ9Jmq2T4L+T2ii/6kZ8OX/QWXzIGZjoHubjt/27e2qDvEfOjiTB6rz5wr2AeSLcNDg+Kt678IjXTydDkejRsnhedlu6/cfj5UzEGrJYnS3T1agi0Z9Bo4X3FRtXgc5IQyPfvjO/CRHKoHQUC5VpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173107; c=relaxed/simple;
	bh=L5HHsYst9ISHE7nYU/AknLZ60xHajjWuFQEfPoaBcIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M7N6BNhztngpOblN/Ff+wMxhoP6H+YcwtuFNwTKZeo+mVhpcs/lSVEM5Sj/bJZT9T13CzchRUP4LmgwoTsOe+FdSZ8VmCBvsr3pyRWsFwFp3t4QFiIgWmTZeRem808tUALqtv9hEUF10bke9MdUo21VlDf+JEUxoVJDRE3+8Bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=USVcAcsv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGhzJ6CJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 11:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741173104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ya1VBObvCjvw/wt8IPOmIefcMv/CC9W7CsnJSGYxhu8=;
	b=USVcAcsvdiUpJRgIsgMxvvL4kGINeGtQ3on3KsRLqJT+1ojYqFZA53/xIF8Ke/AfjLGovd
	WjdhI2GiMDHDxJ2XzZXLWv4HvcizMR5xq4cLznlBQq+MKv+ZZlZp1K9NUdK+0lL2ekojUQ
	ya1/VcRC4FGO6onMAgfaJ9F5E8KKeSwy/3NagymB0MxDpqWUoJRwtvm1lfDmN0N/x0RefY
	/+reB2wasf842u7NbIV6jqoV/prVV2a4yiHYxszsGPoVMtL/VOElt9HsEHgJ9Ol4p5Rn3O
	bjbvvvuQnpjBZdqD9k85jwe5wItubQBusyYKZwUXcpOt0iFyiwTEl77YaU/tEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741173104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ya1VBObvCjvw/wt8IPOmIefcMv/CC9W7CsnJSGYxhu8=;
	b=IGhzJ6CJMKHWTzQcILhs6VGbt3WwypBV1TRc1C5qc1VRYfBHplC6hLOGaFKRm3++cWnWcg
	jo6TzPdGh2NREsBQ==
From: "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Make SEV_STATUS available via SYSFS
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305105234.235553-1-joro@8bytes.org>
References: <20250305105234.235553-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174117310090.14745.4903355074119364385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1d307efcf3b75d1d3aa2f8e7e932eae182d5323a
Gitweb:        https://git.kernel.org/tip/1d307efcf3b75d1d3aa2f8e7e932eae182d5323a
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 05 Mar 2025 11:52:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 12:05:42 +01:00

x86/sev: Make SEV_STATUS available via SYSFS

Current user-space tooling which needs access to the SEV_STATUS MSR is
using the MSR module. The use of this module poses a security risk in
any trusted execution environment and is generally discouraged.

Instead, provide an file in SYSFS in the already existing
/sys/devices/system/cpu/sev/ directory to provide the value of the
SEV_STATUS MSR to user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250305105234.235553-1-joro@8bytes.org
---
 arch/x86/coco/sev/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492ef..7b23fb8 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2678,10 +2678,19 @@ static ssize_t vmpl_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", snp_vmpl);
 }
 
+static ssize_t sev_status_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llx\n", sev_status);
+}
+
 static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+static struct kobj_attribute sev_status_attr = __ATTR_RO(sev_status);
+
 
 static struct attribute *vmpl_attrs[] = {
 	&vmpl_attr.attr,
+	&sev_status_attr.attr,
 	NULL
 };
 

