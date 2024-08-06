Return-Path: <linux-tip-commits+bounces-1951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25158948D33
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B481C237A2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828091BF33E;
	Tue,  6 Aug 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEfKK5SW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eknaqgTN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A161BF339;
	Tue,  6 Aug 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941500; cv=none; b=dQZVJXedAv7GWfz9DC+VyiyF820tXluaiIbPAz9OtJ1aqJDuUQaf9KEQ1/Vx97YzhPm4mIm5/zqt6xaaOoXyk4133TVnderO6tonOQrXbSCS/zQCtQUvMIOk6TWPTAVQrH+EctDkp5ulDCW1TRFWFDa+cKfhItrzEMnFZRYah/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941500; c=relaxed/simple;
	bh=udDo2dN7Vbe93TXBny9bROC4doV9xohXoqT6o+7ou/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GcY7HgEn2gfahpJU7ZAqhyzGwOGNf7PCDK0stmnzE7X79OYFVEncHetlWK8RcT3jcaXT9/f9hIDx0CNNwXVvgXhW/ged478LIJLY97olP4eD9StKask6oQZQox+kVmy7S71Ycil8JY08EL+QjiVpvSkCNtRPG9gAfo5IM1bUX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEfKK5SW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eknaqgTN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Aug 2024 10:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722941496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlTiwVfPnP4uq4Zcocbt4UtVv/6Cjv13toMbotpwZBw=;
	b=pEfKK5SW5uFn9TiiHfrxRRMD6ogimDzffUpx6cHLJy3Yy4Q5cFSMafgc/xS1FiHXfe2H09
	+y0wRiyUX1eZ7HSpCla1yzhNLmmsUGwMxWBNu6su8As9v0AMqxj5B683CdGDOfe/J14htH
	NIzTbra6W/GzkE+wYQA+bVn2/+fln5CnHvFolfH0VljDdQhTERyWZV8rQwBKgFDmZG1Vfc
	Z5wYUUVyCEkfxIE4GDo9jSyyS/ilss6A8vRD5RpvkZVLtKO1OgcxElDakRGrWikGGeZiFN
	2W5uo5zjgdddutNk+H8hp623l3vZkOTzpW0jiITiesM31WEmentYKlRJAbqt8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722941496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlTiwVfPnP4uq4Zcocbt4UtVv/6Cjv13toMbotpwZBw=;
	b=eknaqgTNVF7mzKveOPb+hA/6reZC+f/RrSumsIxpSCfbVvmmvTKKTwTmr3Ey5hGqoPfr7m
	kU9YBf03VKTnl0AA==
From: "tip-bot2 for Dan Williams" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Add usage and style documentation
Cc: Dan Williams <dan.j.williams@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
References:
 <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172294149613.2215.3274492813920223809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d5934e76316e84eced836b6b2bafae1837d1cd58
Gitweb:        https://git.kernel.org/tip/d5934e76316e84eced836b6b2bafae1837d1cd58
Author:        Dan Williams <dan.j.williams@intel.com>
AuthorDate:    Fri, 29 Mar 2024 16:48:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:41 +02:00

cleanup: Add usage and style documentation

When proposing that PCI grow some new cleanup helpers for pci_dev_put()
and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
about expectations and best practices. Upon reviewing an updated
changelog with those details he recommended adding them to documentation
in the header file itself.

Add that documentation and link it into the rendering for
Documentation/core-api/.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com
---
 Documentation/core-api/cleanup.rst |   8 ++-
 Documentation/core-api/index.rst   |   1 +-
 include/linux/cleanup.h            | 136 ++++++++++++++++++++++++++++-
 3 files changed, 145 insertions(+)
 create mode 100644 Documentation/core-api/cleanup.rst

diff --git a/Documentation/core-api/cleanup.rst b/Documentation/core-api/cleanup.rst
new file mode 100644
index 0000000..527eb2f
--- /dev/null
+++ b/Documentation/core-api/cleanup.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Scope-based Cleanup Helpers
+===========================
+
+.. kernel-doc:: include/linux/cleanup.h
+   :doc: scope-based cleanup helpers
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index f147854..b99d2fb 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -35,6 +35,7 @@ Library functionality that is used throughout the kernel.
 
    kobject
    kref
+   cleanup
    assoc_array
    xarray
    maple_tree
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e6138..9c6b4f2 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -4,6 +4,142 @@
 
 #include <linux/compiler.h>
 
+/**
+ * DOC: scope-based cleanup helpers
+ *
+ * The "goto error" pattern is notorious for introducing subtle resource
+ * leaks. It is tedious and error prone to add new resource acquisition
+ * constraints into code paths that already have several unwind
+ * conditions. The "cleanup" helpers enable the compiler to help with
+ * this tedium and can aid in maintaining LIFO (last in first out)
+ * unwind ordering to avoid unintentional leaks.
+ *
+ * As drivers make up the majority of the kernel code base, here is an
+ * example of using these helpers to clean up PCI drivers. The target of
+ * the cleanups are occasions where a goto is used to unwind a device
+ * reference (pci_dev_put()), or unlock the device (pci_dev_unlock())
+ * before returning.
+ *
+ * The DEFINE_FREE() macro can arrange for PCI device references to be
+ * dropped when the associated variable goes out of scope::
+ *
+ *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
+ *	...
+ *	struct pci_dev *dev __free(pci_dev_put) =
+ *		pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * The above will automatically call pci_dev_put() if @dev is non-NULL
+ * when @dev goes out of scope (automatic variable scope). If a function
+ * wants to invoke pci_dev_put() on error, but return @dev (i.e. without
+ * freeing it) on success, it can do::
+ *
+ *	return no_free_ptr(dev);
+ *
+ * ...or::
+ *
+ *	return_ptr(dev);
+ *
+ * The DEFINE_GUARD() macro can arrange for the PCI device lock to be
+ * dropped when the scope where guard() is invoked ends::
+ *
+ *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+ *	...
+ *	guard(pci_dev)(dev);
+ *
+ * The lifetime of the lock obtained by the guard() helper follows the
+ * scope of automatic variable declaration. Take the following example::
+ *
+ *	func(...)
+ *	{
+ *		if (...) {
+ *			...
+ *			guard(pci_dev)(dev); // pci_dev_lock() invoked here
+ *			...
+ *		} // <- implied pci_dev_unlock() triggered here
+ *	}
+ *
+ * Observe the lock is held for the remainder of the "if ()" block not
+ * the remainder of "func()".
+ *
+ * Now, when a function uses both __free() and guard(), or multiple
+ * instances of __free(), the LIFO order of variable definition order
+ * matters. GCC documentation says:
+ *
+ * "When multiple variables in the same scope have cleanup attributes,
+ * at exit from the scope their associated cleanup functions are run in
+ * reverse order of definition (last defined, first cleanup)."
+ *
+ * When the unwind order matters it requires that variables be defined
+ * mid-function scope rather than at the top of the file.  Take the
+ * following example and notice the bug highlighted by "!!"::
+ *
+ *	LIST_HEAD(list);
+ *	DEFINE_MUTEX(lock);
+ *
+ *	struct object {
+ *	        struct list_head node;
+ *	};
+ *
+ *	static struct object *alloc_add(void)
+ *	{
+ *	        struct object *obj;
+ *
+ *	        lockdep_assert_held(&lock);
+ *	        obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+ *	        if (obj) {
+ *	                LIST_HEAD_INIT(&obj->node);
+ *	                list_add(obj->node, &list):
+ *	        }
+ *	        return obj;
+ *	}
+ *
+ *	static void remove_free(struct object *obj)
+ *	{
+ *	        lockdep_assert_held(&lock);
+ *	        list_del(&obj->node);
+ *	        kfree(obj);
+ *	}
+ *
+ *	DEFINE_FREE(remove_free, struct object *, if (_T) remove_free(_T))
+ *	static int init(void)
+ *	{
+ *	        struct object *obj __free(remove_free) = NULL;
+ *	        int err;
+ *
+ *	        guard(mutex)(&lock);
+ *	        obj = alloc_add();
+ *
+ *	        if (!obj)
+ *	                return -ENOMEM;
+ *
+ *	        err = other_init(obj);
+ *	        if (err)
+ *	                return err; // remove_free() called without the lock!!
+ *
+ *	        no_free_ptr(obj);
+ *	        return 0;
+ *	}
+ *
+ * That bug is fixed by changing init() to call guard() and define +
+ * initialize @obj in this order::
+ *
+ *	guard(mutex)(&lock);
+ *	struct object *obj __free(remove_free) = alloc_add();
+ *
+ * Given that the "__free(...) = NULL" pattern for variables defined at
+ * the top of the function poses this potential interdependency problem
+ * the recommendation is to always define and assign variables in one
+ * statement and not group variable definitions at the top of the
+ * function when __free() is used.
+ *
+ * Lastly, given that the benefit of cleanup helpers is removal of
+ * "goto", and that the "goto" statement can jump between scopes, the
+ * expectation is that usage of "goto" and cleanup helpers is never
+ * mixed in the same function. I.e. for a given routine, convert all
+ * resources that need a "goto" cleanup to scope-based cleanup, or
+ * convert none of them.
+ */
+
 /*
  * DEFINE_FREE(name, type, free):
  *	simple helper macro that defines the required wrapper for a __free()

