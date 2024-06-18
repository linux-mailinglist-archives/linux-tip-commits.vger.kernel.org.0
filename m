Return-Path: <linux-tip-commits+bounces-1432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E885D90C841
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944B71F244E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C721C193;
	Tue, 18 Jun 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gWhdTpBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXklnixj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA015886A;
	Tue, 18 Jun 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703902; cv=none; b=o8yribEH40Usr/726aZfYfsqrgpjpo9SwMU77Uji4Tni6NgX9AC4d75Rmrxs4fYyKQH0TSHXVT8OWF2XAl4HQL9LSQ4AxUcGjGdZguj0g/y9GFrVtRfEqk2A/RSp0GsaZbfvn/j2rkQ0/9GHi/kPt6REqxg3IkKGuUTl6/35NHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703902; c=relaxed/simple;
	bh=cSghjsEwm0oSadzX5B2qh5Bvl2He/hbSq75IYjQs+5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fs1K4IqImJ3xp78bqI6SWGrMwhoTt+q0zZyeSZb600Hy970qN4a6V/jDKuH2Tc9a0Y9JjUJdtBuEByCKNH9YMXTDWuuWnP4B+KddIoPerKMIJSx0YQRRq7U2AuRrYT4YQwJesbbgGxCGLECPKLf+c4i99PvEcxGx5N0upHOK1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gWhdTpBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXklnixj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPwyuHKZV5s3QK+XnC78NlAWnjcWwf4f+UR1goYrZek=;
	b=gWhdTpBM45HdULqyUIizJMtLgsH/u9J0cKAZfaYnT0y1Kr34visbmfcsF/Yp3zjo7m7dP0
	y2tsvsAuDw7ho6QW21qgocZKzwj+6A0gHjij4ZELqjz2U5ARBU4jmmW6CyE9Syjtu2CuUH
	GnKNhFxsNyd8fBFlvx2lhIjGuFErX3HiDAbvYJtPkiNELXt1vhXrIfKDrpoX1AXx+dEwmD
	tN7I2taXJfX5U9I0p7x6bybZ1C+yKuSuit67fElcuAK26JYlGfRfU5jGqJlo+1HhW/3iuL
	YQryVP6wWN6A2bS1YmIeDC1jnu4H4vh4RdqoJZg42WbfJ3Mz5VuZ1PTyEglR9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPwyuHKZV5s3QK+XnC78NlAWnjcWwf4f+UR1goYrZek=;
	b=PXklnixjnHtswuKQZxfT8EgqxYzt3fLPYhdLMAzq588MNk/5ZhgmU3EXonAmEM/CP4IgvS
	KFqMpo7fS5KSU/Dw==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] fs/configfs: Add a callback to determine attribute visibility
Cc: Dan Williams <dan.j.williams@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce555c8740a263fab9f83b2cbb44da1af49a2813c=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ce555c8740a263fab9f83b2cbb44da1af49a2813c=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389862.10875.6010778864006857480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0e6a35b93745bb2d8b921fd0520ef730489d41a2
Gitweb:        https://git.kernel.org/tip/0e6a35b93745bb2d8b921fd0520ef730489d41a2
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:53 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

fs/configfs: Add a callback to determine attribute visibility

In order to support dynamic decisions as to whether an attribute should be
created, add a callback that returns a bool to indicate whether the
attribute should be displayed. If no callback is registered, the attribute
is displayed by default.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/e555c8740a263fab9f83b2cbb44da1af49a2813c.1717600736.git.thomas.lendacky@amd.com
---
 fs/configfs/dir.c        | 10 ++++++++++
 include/linux/configfs.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd..43d6bde 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
 static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
+	struct configfs_group_operations *ops;
 	struct configfs_attribute *attr;
 	struct configfs_bin_attribute *bin_attr;
 	int error = 0;
@@ -587,14 +588,23 @@ static int populate_attrs(struct config_item *item)
 
 	if (!t)
 		return -EINVAL;
+
+	ops = t->ct_group_ops;
+
 	if (t->ct_attrs) {
 		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
+				continue;
+
 			if ((error = configfs_create_file(item, attr)))
 				break;
 		}
 	}
 	if (t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
+				continue;
+
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
 				break;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711..c771e9d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -216,6 +216,9 @@ struct configfs_group_operations {
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
+	bool (*is_visible)(struct config_item *item, struct configfs_attribute *attr, int n);
+	bool (*is_bin_visible)(struct config_item *item, struct configfs_bin_attribute *attr,
+			       int n);
 };
 
 struct configfs_subsystem {

