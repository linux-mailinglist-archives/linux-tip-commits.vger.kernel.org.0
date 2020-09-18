Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04B26F736
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIRHmj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgIRHmj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB1C06178C;
        Fri, 18 Sep 2020 00:42:38 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMxb0iVltLpXi4mW6gsjUOW/tEO6TObEcMbuSON9Ypg=;
        b=Fa3XrajxcOCqlpmSQDvgBxqqm/gRuiYblP0KLiGFXaU+YKONzYAisinB8Y47K44XwW66BV
        YLPhz4DUNOOA/ayaKD6nuLN8aYUnVbPPqRkLFQ+RtMDKKF35XRrdx4QAEVWTxTSB7Uw+tR
        JZ25Em0pBjzcsA4wjsGK6NoTJz4r/sfxQ7G1xO3RaPdr1qhEWQ4NRs6FZ/nifDPuieRsli
        St8YtqIgZ+QYg9nYTlqjqORLvbKqz1aFkzPe9mRHy9uoD+RVxHB0qklakn7IqqjrlV+JrU
        DAQa29uEC2Unuvd9q2FmgxCzF0G4aRx/2cQrToLnSt9kk2bXvPn5/OExwlkYVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMxb0iVltLpXi4mW6gsjUOW/tEO6TObEcMbuSON9Ypg=;
        b=Ga1YmZDW2raWmMk34xKvx8cAqi7cWmUB/k1sJUdE9de8F4nysRGDd2RmCxKWH9b3Rfi/Nx
        +zacAYY26Yq45vBg==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] drm, iommu: Change type of pasid to u32
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-2-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495461.15536.728553495659912770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     c7b6bac9c72c5fcbd6e9e12545bd3022c7f21860
Gitweb:        https://git.kernel.org/tip/c7b6bac9c72c5fcbd6e9e12545bd3022c7f21860
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:05 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 19:21:16 +02:00

drm, iommu: Change type of pasid to u32

PASID is defined as a few different types in iommu including "int",
"u32", and "unsigned int". To be consistent and to match with uapi
definitions, define PASID and its variations (e.g. max PASID) as "u32".
"u32" is also shorter and a little more explicit than "unsigned int".

No PASID type change in uapi although it defines PASID as __u64 in
some places.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/1600187413-163670-2-git-send-email-fenghua.yu@intel.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c               |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h               |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                |  8 +--
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h               |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  7 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.c               |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.h               |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c                |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 20 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              |  2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h       |  2 +-
 drivers/iommu/amd/amd_iommu.h                         | 10 +--
 drivers/iommu/amd/iommu.c                             | 31 +++++-----
 drivers/iommu/amd/iommu_v2.c                          | 20 +++---
 drivers/iommu/intel/dmar.c                            |  7 +-
 drivers/iommu/intel/iommu.c                           |  4 +-
 drivers/iommu/intel/pasid.c                           | 31 ++++------
 drivers/iommu/intel/pasid.h                           | 24 ++++----
 drivers/iommu/intel/svm.c                             | 12 ++--
 drivers/iommu/iommu.c                                 |  2 +-
 drivers/misc/uacce/uacce.c                            |  2 +-
 include/linux/amd-iommu.h                             |  8 +--
 include/linux/intel-iommu.h                           | 12 ++--
 include/linux/intel-svm.h                             |  2 +-
 include/linux/iommu.h                                 | 10 +--
 include/linux/uacce.h                                 |  2 +-
 38 files changed, 141 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index ffe149a..dfef5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -207,11 +207,11 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
 	})
 
 /* GPUVM API */
-int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasid,
+int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 					void **vm, void **process_info,
 					struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
-					struct file *filp, unsigned int pasid,
+					struct file *filp, u32 pasid,
 					void **vm, void **process_info,
 					struct dma_fence **ef);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index bf927f4..ee531c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -105,7 +105,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 	unlock_srbm(kgd);
 }
 
-static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
+static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 					unsigned int vmid)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 744366c..4d41317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -139,7 +139,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 	unlock_srbm(kgd);
 }
 
-static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
+static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 					unsigned int vmid)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index feab4cc..35917d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -96,7 +96,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 	unlock_srbm(kgd);
 }
 
-static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
+static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 					unsigned int vmid)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1102de7..1abfe63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -110,7 +110,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 	unlock_srbm(kgd);
 }
 
-int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
+int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 					unsigned int vmid)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index aedf67d..ff2bc72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -26,7 +26,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 		uint32_t sh_mem_config,
 		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
 		uint32_t sh_mem_bases);
-int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
+int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 		unsigned int vmid);
 int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);
 int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a58af51..d02c5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -992,7 +992,7 @@ create_evict_fence_fail:
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasid,
+int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 					  void **vm, void **process_info,
 					  struct dma_fence **ef)
 {
@@ -1028,7 +1028,7 @@ amdgpu_vm_init_fail:
 }
 
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
-					   struct file *filp, unsigned int pasid,
+					   struct file *filp, u32 pasid,
 					   void **vm, void **process_info,
 					   struct dma_fence **ef)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 7521f4a..6e9a9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -43,7 +43,7 @@ static DEFINE_IDA(amdgpu_pasid_ida);
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
 	struct dma_fence_cb cb;
-	unsigned int pasid;
+	u32 pasid;
 };
 
 /**
@@ -79,7 +79,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
  * amdgpu_pasid_free - Free a PASID
  * @pasid: PASID to free
  */
-void amdgpu_pasid_free(unsigned int pasid)
+void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
 	ida_simple_remove(&amdgpu_pasid_ida, pasid);
@@ -105,7 +105,7 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fence,
  * Free the pasid only after all the fences in resv are signaled.
  */
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
-			       unsigned int pasid)
+			       u32 pasid)
 {
 	struct dma_fence *fence, **fences;
 	struct amdgpu_pasid_cb *cb;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 8e58325..0c3b4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -71,9 +71,9 @@ struct amdgpu_vmid_mgr {
 };
 
 int amdgpu_pasid_alloc(unsigned int bits);
-void amdgpu_pasid_free(unsigned int pasid);
+void amdgpu_pasid_free(u32 pasid);
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
-			       unsigned int pasid);
+			       u32 pasid);
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4145480..b403b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1084,7 +1084,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct amdgpu_bo_list *list;
 	struct amdgpu_bo *pd;
-	unsigned int pasid;
+	u32 pasid;
 	int handle;
 
 	if (!fpriv)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71e005c..cb1d7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2785,7 +2785,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, unsigned int pasid)
+		   int vm_context, u32 pasid)
 {
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
@@ -2956,7 +2956,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  * 0 for success, -errno for errors.
  */
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   unsigned int pasid)
+			   u32 pasid)
 {
 	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
 	int r;
@@ -3254,7 +3254,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * @pasid: PASID identifier for VM
  * @task_info: task_info to fill.
  */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
+void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			 struct amdgpu_task_info *task_info)
 {
 	struct amdgpu_vm *vm;
@@ -3298,7 +3298,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
  * shouldn't be reported any more.
  */
-bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
+bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t addr)
 {
 	struct amdgpu_bo *root;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 770025a..ffbc0cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -372,8 +372,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, unsigned int pasid);
-int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, unsigned int pasid);
+		   int vm_context, u32 pasid);
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
@@ -430,9 +430,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
+void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			     struct amdgpu_task_info *task_info);
-bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
+bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t addr);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 24b4717..dcb1d89 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -91,7 +91,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 			(const struct cik_ih_ring_entry *)ih_ring_entry;
 	uint32_t context_id = ihre->data & 0xfffffff;
 	unsigned int vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
-	unsigned int pasid = (ihre->ring_id & 0xffff0000) >> 16;
+	u32 pasid = (ihre->ring_id & 0xffff0000) >> 16;
 
 	if (pasid == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 27bcc5b..b258a3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -45,7 +45,7 @@ static void dbgdev_address_watch_disable_nodiq(struct kfd_dev *dev)
 }
 
 static int dbgdev_diq_submit_ib(struct kfd_dbgdev *dbgdev,
-				unsigned int pasid, uint64_t vmid0_address,
+				u32 pasid, uint64_t vmid0_address,
 				uint32_t *packet_buff, size_t size_in_bytes)
 {
 	struct pm4__release_mem *rm_packet;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
index a04a1fe..f9c6df1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
@@ -275,7 +275,7 @@ struct kfd_dbgdev {
 };
 
 struct kfd_dbgmgr {
-	unsigned int pasid;
+	u32 pasid;
 	struct kfd_dev *dev;
 	struct kfd_dbgdev *dbgdev;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0e60b0..1ec2567 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -40,7 +40,7 @@
 #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
 
 static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
-					unsigned int pasid, unsigned int vmid);
+				  u32 pasid, unsigned int vmid);
 
 static int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
@@ -948,7 +948,7 @@ out:
 }
 
 static int
-set_pasid_vmid_mapping(struct device_queue_manager *dqm, unsigned int pasid,
+set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
 	return dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
@@ -1979,8 +1979,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
-int kfd_process_vm_fault(struct device_queue_manager *dqm,
-			 unsigned int pasid)
+int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index a9583b9..ba2c2ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -460,7 +460,7 @@ static void set_event_from_interrupt(struct kfd_process *p,
 	}
 }
 
-void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
+void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				uint32_t valid_id_bits)
 {
 	struct kfd_event *ev = NULL;
@@ -872,7 +872,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 }
 
 #ifdef KFD_SUPPORT_IOMMU_V2
-void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
+void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
 		unsigned long address, bool is_write_requested,
 		bool is_execute_requested)
 {
@@ -950,7 +950,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
 }
 #endif /* KFD_SUPPORT_IOMMU_V2 */
 
-void kfd_signal_hw_exception_event(unsigned int pasid)
+void kfd_signal_hw_exception_event(u32 pasid)
 {
 	/*
 	 * Because we are called from arbitrary context (workqueue) as opposed
@@ -971,7 +971,7 @@ void kfd_signal_hw_exception_event(unsigned int pasid)
 	kfd_unref_process(p);
 }
 
-void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
+void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
 				struct kfd_vm_fault_info *info)
 {
 	struct kfd_event *ev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index c7ac6c7..c8fe5db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -79,7 +79,7 @@ struct kfd_event {
 #define KFD_EVENT_TYPE_DEBUG 5
 #define KFD_EVENT_TYPE_MEMORY 8
 
-extern void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
-					uint32_t valid_id_bits);
+extern void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
+				       uint32_t valid_id_bits);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 7c8786b..e8ef388 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -139,7 +139,7 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
 }
 
 /* Callback for process shutdown invoked by the IOMMU driver */
-static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
+static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, u32 pasid)
 {
 	struct kfd_dev *dev = kfd_device_by_pci_dev(pdev);
 	struct kfd_process *p;
@@ -185,8 +185,8 @@ static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
 }
 
 /* This function called by IOMMU driver on PPR failure */
-static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
-		unsigned long address, u16 flags)
+static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
+				unsigned long address, u16 flags)
 {
 	struct kfd_dev *dev;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
index 2a07c4f..af5816f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
@@ -51,7 +51,7 @@ unsigned int kfd_get_pasid_limit(void)
 	return 1U << pasid_bits;
 }
 
-unsigned int kfd_pasid_alloc(void)
+u32 kfd_pasid_alloc(void)
 {
 	int r = amdgpu_pasid_alloc(pasid_bits);
 
@@ -63,7 +63,7 @@ unsigned int kfd_pasid_alloc(void)
 	return 0;
 }
 
-void kfd_pasid_free(unsigned int pasid)
+void kfd_pasid_free(u32 pasid)
 {
 	amdgpu_pasid_free(pasid);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6727e9d..922ae13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -723,7 +723,7 @@ struct kfd_process {
 	/* We want to receive a notification when the mm_struct is destroyed */
 	struct mmu_notifier mmu_notifier;
 
-	uint16_t pasid;
+	u32 pasid;
 	unsigned int doorbell_index;
 
 	/*
@@ -800,7 +800,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 struct kfd_process *kfd_create_process(struct file *filep);
 struct kfd_process *kfd_get_process(const struct task_struct *);
-struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
+struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 void kfd_unref_process(struct kfd_process *p);
 int kfd_process_evict_queues(struct kfd_process *p);
@@ -841,8 +841,8 @@ int kfd_pasid_init(void);
 void kfd_pasid_exit(void);
 bool kfd_set_pasid_limit(unsigned int new_limit);
 unsigned int kfd_get_pasid_limit(void);
-unsigned int kfd_pasid_alloc(void);
-void kfd_pasid_free(unsigned int pasid);
+u32 kfd_pasid_alloc(void);
+void kfd_pasid_free(u32 pasid);
 
 /* Doorbells */
 size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
@@ -927,7 +927,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 					enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
-int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int pasid);
+int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid);
 
 /* Process Queue Manager */
 struct process_queue_node {
@@ -1049,12 +1049,12 @@ int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
 		       bool all, uint32_t user_timeout_ms,
 		       uint32_t *wait_result);
-void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
+void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				uint32_t valid_id_bits);
 void kfd_signal_iommu_event(struct kfd_dev *dev,
-		unsigned int pasid, unsigned long address,
-		bool is_write_requested, bool is_execute_requested);
-void kfd_signal_hw_exception_event(unsigned int pasid);
+			    u32 pasid, unsigned long address,
+			    bool is_write_requested, bool is_execute_requested);
+void kfd_signal_hw_exception_event(u32 pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
 int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
@@ -1065,7 +1065,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 		     uint64_t *event_page_offset, uint32_t *event_slot_index);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
-void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
+void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
 				struct kfd_vm_fault_info *info);
 
 void kfd_signal_reset_event(struct kfd_dev *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 40695d5..6277930 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1306,7 +1306,7 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 }
 
 /* This increments the process->ref counter. */
-struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid)
+struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
 {
 	struct kfd_process *p, *ret_p = NULL;
 	unsigned int temp;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index a3c238c..301de49 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -226,7 +226,7 @@ struct kfd2kgd_calls {
 			uint32_t sh_mem_config,	uint32_t sh_mem_ape1_base,
 			uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases);
 
-	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, unsigned int pasid,
+	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, u32 pasid,
 					unsigned int vmid);
 
 	int (*init_interrupts)(struct kgd_dev *kgd, uint32_t pipe_id);
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5730971..030ee90 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,12 +45,12 @@ extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
 extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
-extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
+extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 				u64 address);
-extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
-extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
+extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
+extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 				     unsigned long cr3);
-extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
+extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
 extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
 
 #ifdef CONFIG_IRQ_REMAP
@@ -66,7 +66,7 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 #define PPR_INVALID			0x1
 #define PPR_FAILURE			0xf
 
-extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
+extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 				  int status, int tag);
 
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07ae8b9..a21c717 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -513,10 +513,11 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
 	struct device *dev = iommu->iommu.dev;
-	int type, devid, pasid, flags, tag;
+	int type, devid, flags, tag;
 	volatile u32 *event = __evt;
 	int count = 0;
 	u64 address;
+	u32 pasid;
 
 retry:
 	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
@@ -909,7 +910,7 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
 }
 
-static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
+static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
 				  u64 address, bool size)
 {
 	memset(cmd, 0, sizeof(*cmd));
@@ -927,7 +928,7 @@ static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 }
 
-static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
+static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 				  int qdep, u64 address, bool size)
 {
 	memset(cmd, 0, sizeof(*cmd));
@@ -947,7 +948,7 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
 }
 
-static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, int pasid,
+static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 			       int status, int tag, bool gn)
 {
 	memset(cmd, 0, sizeof(*cmd));
@@ -2786,7 +2787,7 @@ out:
 }
 EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
 
-static int __flush_pasid(struct protection_domain *domain, int pasid,
+static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			 u64 address, bool size)
 {
 	struct iommu_dev_data *dev_data;
@@ -2847,13 +2848,13 @@ out:
 	return ret;
 }
 
-static int __amd_iommu_flush_page(struct protection_domain *domain, int pasid,
+static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 				  u64 address)
 {
 	return __flush_pasid(domain, pasid, address, false);
 }
 
-int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
+int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 			 u64 address)
 {
 	struct protection_domain *domain = to_pdomain(dom);
@@ -2868,13 +2869,13 @@ int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
 }
 EXPORT_SYMBOL(amd_iommu_flush_page);
 
-static int __amd_iommu_flush_tlb(struct protection_domain *domain, int pasid)
+static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
 	return __flush_pasid(domain, pasid, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 			     true);
 }
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid)
+int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
@@ -2888,7 +2889,7 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid)
 }
 EXPORT_SYMBOL(amd_iommu_flush_tlb);
 
-static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
+static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
 	int index;
 	u64 *pte;
@@ -2920,7 +2921,7 @@ static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
 	return pte;
 }
 
-static int __set_gcr3(struct protection_domain *domain, int pasid,
+static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 		      unsigned long cr3)
 {
 	struct domain_pgtable pgtable;
@@ -2939,7 +2940,7 @@ static int __set_gcr3(struct protection_domain *domain, int pasid,
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-static int __clear_gcr3(struct protection_domain *domain, int pasid)
+static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 {
 	struct domain_pgtable pgtable;
 	u64 *pte;
@@ -2957,7 +2958,7 @@ static int __clear_gcr3(struct protection_domain *domain, int pasid)
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
+int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3)
 {
 	struct protection_domain *domain = to_pdomain(dom);
@@ -2972,7 +2973,7 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 }
 EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid)
+int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
@@ -2986,7 +2987,7 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid)
 }
 EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 0d175ae..5ecc0bc 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -40,7 +40,7 @@ struct pasid_state {
 	struct mmu_notifier mn;                 /* mmu_notifier handle */
 	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
 	struct device_state *device_state;	/* Link to our device_state */
-	int pasid;				/* PASID index */
+	u32 pasid;				/* PASID index */
 	bool invalid;				/* Used during setup and
 						   teardown of the pasid */
 	spinlock_t lock;			/* Protect pri_queues and
@@ -70,7 +70,7 @@ struct fault {
 	struct mm_struct *mm;
 	u64 address;
 	u16 devid;
-	u16 pasid;
+	u32 pasid;
 	u16 tag;
 	u16 finish;
 	u16 flags;
@@ -150,7 +150,7 @@ static void put_device_state(struct device_state *dev_state)
 
 /* Must be called under dev_state->lock */
 static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state,
-						  int pasid, bool alloc)
+						  u32 pasid, bool alloc)
 {
 	struct pasid_state **root, **ptr;
 	int level, index;
@@ -184,7 +184,7 @@ static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state
 
 static int set_pasid_state(struct device_state *dev_state,
 			   struct pasid_state *pasid_state,
-			   int pasid)
+			   u32 pasid)
 {
 	struct pasid_state **ptr;
 	unsigned long flags;
@@ -211,7 +211,7 @@ out_unlock:
 	return ret;
 }
 
-static void clear_pasid_state(struct device_state *dev_state, int pasid)
+static void clear_pasid_state(struct device_state *dev_state, u32 pasid)
 {
 	struct pasid_state **ptr;
 	unsigned long flags;
@@ -229,7 +229,7 @@ out_unlock:
 }
 
 static struct pasid_state *get_pasid_state(struct device_state *dev_state,
-					   int pasid)
+					   u32 pasid)
 {
 	struct pasid_state **ptr, *ret = NULL;
 	unsigned long flags;
@@ -594,7 +594,7 @@ static struct notifier_block ppr_nb = {
 	.notifier_call = ppr_notifier,
 };
 
-int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
+int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 			 struct task_struct *task)
 {
 	struct pasid_state *pasid_state;
@@ -615,7 +615,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 		return -EINVAL;
 
 	ret = -EINVAL;
-	if (pasid < 0 || pasid >= dev_state->max_pasids)
+	if (pasid >= dev_state->max_pasids)
 		goto out;
 
 	ret = -ENOMEM;
@@ -679,7 +679,7 @@ out:
 }
 EXPORT_SYMBOL(amd_iommu_bind_pasid);
 
-void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
+void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid)
 {
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
@@ -695,7 +695,7 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 	if (dev_state == NULL)
 		return;
 
-	if (pasid < 0 || pasid >= dev_state->max_pasids)
+	if (pasid >= dev_state->max_pasids)
 		goto out;
 
 	pasid_state = get_pasid_state(dev_state, pasid);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345..e4cfa73 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1482,7 +1482,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
-			  u64 granu, int pasid)
+			  u64 granu, u32 pasid)
 {
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
 
@@ -1796,7 +1796,7 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 }
 
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
-		u8 fault_reason, int pasid, u16 source_id,
+		u8 fault_reason, u32 pasid, u16 source_id,
 		unsigned long long addr)
 {
 	const char *reason;
@@ -1846,7 +1846,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		u8 fault_reason;
 		u16 source_id;
 		u64 guest_addr;
-		int type, pasid;
+		u32 pasid;
+		int type;
 		u32 data;
 		bool pasid_present;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87b17ba..44bb6fd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2527,7 +2527,7 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-				    int pasid)
+				    u32 pasid)
 {
 	int flags = PASID_FLAG_SUPERVISOR_MODE;
 	struct dma_pte *pgd = domain->pgd;
@@ -5173,7 +5173,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		return -ENODEV;
 
 	if (domain->default_pasid <= 0) {
-		int pasid;
+		u32 pasid;
 
 		/* No private data needed for the default pasid */
 		pasid = ioasid_alloc(NULL, PASID_MIN,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index e6faedf..b92af83 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -27,7 +27,7 @@
 static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
 
-int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
+int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
 {
 	unsigned long flags;
 	u8 status_code;
@@ -58,7 +58,7 @@ int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
 	return ret;
 }
 
-void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
+void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid)
 {
 	unsigned long flags;
 	u8 status_code;
@@ -146,7 +146,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	struct pasid_table *pasid_table;
 	struct pasid_table_opaque data;
 	struct page *pages;
-	int max_pasid = 0;
+	u32 max_pasid = 0;
 	int ret, order;
 	int size;
 
@@ -168,7 +168,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	INIT_LIST_HEAD(&pasid_table->dev);
 
 	if (info->pasid_supported)
-		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
+		max_pasid = min_t(u32, pci_max_pasids(to_pci_dev(dev)),
 				  intel_pasid_max_id);
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
@@ -242,7 +242,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 	return info->pasid_table->max_pasid;
 }
 
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
+struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
@@ -251,8 +251,7 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
 	int dir_index, index;
 
 	pasid_table = intel_pasid_get_table(dev);
-	if (WARN_ON(!pasid_table || pasid < 0 ||
-		    pasid >= intel_pasid_get_dev_max_id(dev)))
+	if (WARN_ON(!pasid_table || pasid >= intel_pasid_get_dev_max_id(dev)))
 		return NULL;
 
 	dir = pasid_table->table;
@@ -305,7 +304,7 @@ static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
 }
 
 static void
-intel_pasid_clear_entry(struct device *dev, int pasid, bool fault_ignore)
+intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
 {
 	struct pasid_entry *pe;
 
@@ -444,7 +443,7 @@ pasid_set_eafe(struct pasid_entry *pe)
 
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
-				    u16 did, int pasid)
+				    u16 did, u32 pasid)
 {
 	struct qi_desc desc;
 
@@ -473,7 +472,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
 
 static void
 devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
-			       struct device *dev, int pasid)
+			       struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	u16 sid, qdep, pfsid;
@@ -499,7 +498,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
-				 int pasid, bool fault_ignore)
+				 u32 pasid, bool fault_ignore)
 {
 	struct pasid_entry *pte;
 	u16 did;
@@ -524,7 +523,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 static void pasid_flush_caches(struct intel_iommu *iommu,
 				struct pasid_entry *pte,
-				int pasid, u16 did)
+			       u32 pasid, u16 did)
 {
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
@@ -543,7 +542,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
  */
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
-				  int pasid, u16 did, int flags)
+				  u32 pasid, u16 did, int flags)
 {
 	struct pasid_entry *pte;
 
@@ -616,7 +615,7 @@ static inline int iommu_skip_agaw(struct dmar_domain *domain,
  */
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
-				   struct device *dev, int pasid)
+				   struct device *dev, u32 pasid)
 {
 	struct pasid_entry *pte;
 	struct dma_pte *pgd;
@@ -674,7 +673,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
  */
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
-				   struct device *dev, int pasid)
+				   struct device *dev, u32 pasid)
 {
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
@@ -760,7 +759,7 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
  * @addr_width: Address width of the first level (guest)
  */
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
-			     pgd_t *gpgd, int pasid,
+			     pgd_t *gpgd, u32 pasid,
 			     struct iommu_gpasid_bind_data_vtd *pasid_data,
 			     struct dmar_domain *domain, int addr_width)
 {
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index c985076..97dfcff 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -72,7 +72,7 @@ struct pasid_entry {
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
 	int			order;		/* page order of pasid table */
-	int			max_pasid;	/* max pasid */
+	u32			max_pasid;	/* max pasid */
 	struct list_head	dev;		/* device list */
 };
 
@@ -98,31 +98,31 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
-extern u32 intel_pasid_max_id;
+extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
-void intel_pasid_free_id(int pasid);
-void *intel_pasid_lookup_id(int pasid);
+void intel_pasid_free_id(u32 pasid);
+void *intel_pasid_lookup_id(u32 pasid);
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_get_dev_max_id(struct device *dev);
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
+struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
-				  int pasid, u16 did, int flags);
+				  u32 pasid, u16 did, int flags);
 int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
-				   struct device *dev, int pasid);
+				   struct device *dev, u32 pasid);
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
-				   struct device *dev, int pasid);
+				   struct device *dev, u32 pasid);
 int intel_pasid_setup_nested(struct intel_iommu *iommu,
-			     struct device *dev, pgd_t *pgd, int pasid,
+			     struct device *dev, pgd_t *pgd, u32 pasid,
 			     struct iommu_gpasid_bind_data_vtd *pasid_data,
 			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, int pasid,
+				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
-int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
-void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
+int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
+void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 95c3164..e78a74a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -23,7 +23,7 @@
 #include "pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
-static void intel_svm_drain_prq(struct device *dev, int pasid);
+static void intel_svm_drain_prq(struct device *dev, u32 pasid);
 
 #define PRQ_ORDER 0
 
@@ -399,7 +399,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	return ret;
 }
 
-int intel_svm_unbind_gpasid(struct device *dev, int pasid)
+int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
@@ -620,7 +620,7 @@ out:
 }
 
 /* Caller must hold pasid_mutex */
-static int intel_svm_unbind_mm(struct device *dev, int pasid)
+static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
@@ -739,7 +739,7 @@ static bool is_canonical_address(u64 addr)
  * described in VT-d spec CH7.10 to drain all page requests and page
  * responses pending in the hardware.
  */
-static void intel_svm_drain_prq(struct device *dev, int pasid)
+static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct dmar_domain *domain;
@@ -1067,10 +1067,10 @@ void intel_svm_unbind(struct iommu_sva *sva)
 	mutex_unlock(&pasid_mutex);
 }
 
-int intel_svm_get_pasid(struct iommu_sva *sva)
+u32 intel_svm_get_pasid(struct iommu_sva *sva)
 {
 	struct intel_svm_dev *sdev;
-	int pasid;
+	u32 pasid;
 
 	mutex_lock(&pasid_mutex);
 	sdev = to_intel_svm_dev(sva);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25..0e4fbdc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2839,7 +2839,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
-int iommu_sva_get_pasid(struct iommu_sva *handle)
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
 
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index a5b8dab..4cb7a5b 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -93,7 +93,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
 
 static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 {
-	int pasid;
+	u32 pasid;
 	struct iommu_sva *handle;
 
 	if (!(uacce->flags & UACCE_DEV_SVA))
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 21e950e..4507172 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -76,7 +76,7 @@ extern void amd_iommu_free_device(struct pci_dev *pdev);
  *
  * The function returns 0 on success or a negative value on error.
  */
-extern int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
+extern int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 				struct task_struct *task);
 
 /**
@@ -88,7 +88,7 @@ extern int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
  * When this function returns the device is no longer using the PASID
  * and the PASID is no longer bound to its task.
  */
-extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid);
+extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid);
 
 /**
  * amd_iommu_set_invalid_ppr_cb() - Register a call-back for failed
@@ -114,7 +114,7 @@ extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid);
 #define AMD_IOMMU_INV_PRI_RSP_FAIL	2
 
 typedef int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev,
-					int pasid,
+					u32 pasid,
 					unsigned long address,
 					u16);
 
@@ -166,7 +166,7 @@ extern int amd_iommu_device_info(struct pci_dev *pdev,
  * @cb: The call-back function
  */
 
-typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid);
+typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, u32 pasid);
 
 extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
 					   amd_iommu_invalidate_ctx cb);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f2..7322073 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -549,7 +549,7 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	u64		max_addr;	/* maximum mapped address */
 
-	int		default_pasid;	/*
+	u32		default_pasid;	/*
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
 					 */
@@ -708,7 +708,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
 			      unsigned int size_order);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
-			  int pasid);
+			  u32 pasid);
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options);
@@ -737,11 +737,11 @@ extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
-int intel_svm_unbind_gpasid(struct device *dev, int pasid);
+int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
 				 void *drvdata);
 void intel_svm_unbind(struct iommu_sva *handle);
-int intel_svm_get_pasid(struct iommu_sva *handle);
+u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 
@@ -753,7 +753,7 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct svm_dev_ops *ops;
 	struct iommu_sva sva;
-	int pasid;
+	u32 pasid;
 	int users;
 	u16 did;
 	u16 dev_iotlb:1;
@@ -766,7 +766,7 @@ struct intel_svm {
 
 	struct intel_iommu *iommu;
 	int flags;
-	int pasid;
+	u32 pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index c9e7e60..39d368a 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -11,7 +11,7 @@
 struct device;
 
 struct svm_dev_ops {
-	void (*fault_cb)(struct device *dev, int pasid, u64 address,
+	void (*fault_cb)(struct device *dev, u32 pasid, u64 address,
 			 void *private, int rwxp, int response);
 };
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209e..e57e819 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -286,7 +286,7 @@ struct iommu_ops {
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
-	int (*sva_get_pasid)(struct iommu_sva *handle);
+	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
@@ -296,7 +296,7 @@ struct iommu_ops {
 	int (*sva_bind_gpasid)(struct iommu_domain *domain,
 			struct device *dev, struct iommu_gpasid_bind_data *data);
 
-	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
+	int (*sva_unbind_gpasid)(struct device *dev, u32 pasid);
 
 	int (*def_domain_type)(struct device *dev);
 
@@ -634,7 +634,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
 					void *drvdata);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
-int iommu_sva_get_pasid(struct iommu_sva *handle);
+u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1027,7 +1027,7 @@ static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 }
 
-static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
+static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
@@ -1046,7 +1046,7 @@ static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 }
 
 static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+					   struct device *dev, u32 pasid)
 {
 	return -ENODEV;
 }
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 454c2f6..48e319f 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -81,7 +81,7 @@ struct uacce_queue {
 	struct list_head list;
 	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
 	enum uacce_q_state state;
-	int pasid;
+	u32 pasid;
 	struct iommu_sva *handle;
 };
 
