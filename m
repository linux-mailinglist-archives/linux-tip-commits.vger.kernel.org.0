Return-Path: <linux-tip-commits+bounces-4663-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECFA7BFB3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C083BCE5C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F971F426C;
	Fri,  4 Apr 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hOxRXSmQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/3eiIwA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DA1F582D;
	Fri,  4 Apr 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777411; cv=none; b=J8kplIM70sSXWXLcS6aGg6ZMxn4SB+sbsuRl+DpGN/Pc/vlMwt7w6NRhpwRBNWof/P0iyEfM+/GYzAVVmBOOAmI9RBT4LDgaejJ2djzrPhOlaHWgyLjvr7PZqylsTg1Kq0IYddvLi/01Vq4rtxybC2ihU7QZ0V/1PKuAhIL7L5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777411; c=relaxed/simple;
	bh=4ax/7Db+kpuP/XGpUsNkBSOd/DJZKFiJbhhhQ2ZLMnM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=lXkwn8pqgw/osShxiduiRzq/kQSfga7oFrorpG6yp9L6ci2ZO7x/tJJXUMK5mYv4kOjN9vglqfgqhy4XxIMURrW9GnlIsNE+a4pGRci8waJ3xUGlLjoe6q6HB3EPZm9pFxiDgvK1ScLWGjlR/cUF8CJb8PFAR6P/5mB7vU8b/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hOxRXSmQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/3eiIwA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pt5drdpH4b0yG7W3zLSzKuIvZVUPnxb//wdZiy7JtBg=;
	b=hOxRXSmQsHYrXwqC2OpE+IbMpOKWkxK1r8RH4+BguEtQMWIO98DWHhuKuPf48gvAowMELn
	TVuW7CEHnlTk1UO74rKln62nX4ZkJn8lZI6B80fq5QwA5tYpaPXzoanddB38P3rhtCrYUn
	waVOg7+y1er673P6uUwAXlN4DNtvd5Te6vwy+9iZQpe1eM7spGrylDHPeFBYbXbx8H7Y/J
	7GHYzLojKn+IK8MXTNUSG8YGdRXk85dLPNSUpxXp8jHXaJq7ZNT40fWsVq1wZ6DbMIwcTM
	I3lknAH0zZHXAwOda17HEv9PC67yhlG8braqFvRdz+TZfZc3zc3Ze94qAo/Knw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pt5drdpH4b0yG7W3zLSzKuIvZVUPnxb//wdZiy7JtBg=;
	b=F/3eiIwAKqKMrcBVmmK9CG1Wg/tXWFua4YuVndIXPMhLFa3qtOgWxs3pwUXkMmhGSaljzg
	0NoVwrnvEyqqEUCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] treewide: Switch to timer_delete[_sync]()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377738592.31282.4699748226902066455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     915bfe3b63168b863b4c14a0c9cffa0ee9acfeeb
Gitweb:        https://git.kernel.org/tip/915bfe3b63168b863b4c14a0c9cffa0ee9acfeeb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 17 Mar 2025 14:52:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:09 +02:00

treewide: Switch to timer_delete[_sync]()

timer_delete[_sync]() replace del_timer[_sync](). Convert the whole tree
over and remove the historical wrapper inlines.

Conversion was done with coccinelle plus manual fixups where necessary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/kernel/srmcons.c                               |  2 +-
 arch/arm/mach-footbridge/dc21285.c                        |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                            |  4 +-
 arch/m68k/amiga/amisound.c                                |  2 +-
 arch/m68k/mac/macboing.c                                  |  4 +-
 arch/mips/sgi-ip22/ip22-reset.c                           |  2 +-
 arch/powerpc/kvm/booke.c                                  |  4 +-
 arch/powerpc/platforms/cell/spufs/sched.c                 |  6 +-
 arch/powerpc/platforms/powermac/low_i2c.c                 |  2 +-
 arch/s390/kernel/time.c                                   |  2 +-
 arch/s390/mm/cmm.c                                        |  6 +-
 arch/sh/drivers/pci/common.c                              |  4 +-
 arch/sparc/kernel/led.c                                   |  4 +-
 arch/um/drivers/vector_kern.c                             |  2 +-
 arch/x86/kernel/cpu/mce/core.c                            |  6 +-
 arch/x86/kvm/xen.c                                        |  4 +-
 arch/xtensa/platforms/iss/console.c                       |  2 +-
 arch/xtensa/platforms/iss/network.c                       |  2 +-
 block/blk-core.c                                          |  2 +-
 block/blk-stat.c                                          |  2 +-
 block/blk-stat.h                                          |  2 +-
 block/blk-throttle.c                                      |  4 +-
 drivers/accel/qaic/qaic_timesync.c                        |  2 +-
 drivers/accessibility/speakup/main.c                      | 18 +--
 drivers/accessibility/speakup/synth.c                     |  2 +-
 drivers/ata/libata-eh.c                                   |  2 +-
 drivers/atm/idt77105.c                                    |  4 +-
 drivers/atm/iphase.c                                      |  2 +-
 drivers/atm/lanai.c                                       |  2 +-
 drivers/atm/nicstar.c                                     |  2 +-
 drivers/atm/suni.c                                        |  2 +-
 drivers/auxdisplay/line-display.c                         |  8 +-
 drivers/auxdisplay/panel.c                                |  4 +-
 drivers/base/devcoredump.c                                |  2 +-
 drivers/base/power/main.c                                 |  2 +-
 drivers/base/power/wakeup.c                               |  6 +-
 drivers/block/amiflop.c                                   | 10 +-
 drivers/block/aoe/aoedev.c                                |  2 +-
 drivers/block/aoe/aoemain.c                               |  2 +-
 drivers/block/ataflop.c                                   | 12 +-
 drivers/block/drbd/drbd_main.c                            |  2 +-
 drivers/block/drbd/drbd_nl.c                              |  2 +-
 drivers/block/drbd/drbd_receiver.c                        |  2 +-
 drivers/block/floppy.c                                    |  8 +-
 drivers/block/sunvdc.c                                    |  2 +-
 drivers/block/swim3.c                                     | 10 +-
 drivers/bluetooth/bluecard_cs.c                           |  4 +-
 drivers/bluetooth/hci_bcsp.c                              |  2 +-
 drivers/bluetooth/hci_h5.c                                |  6 +-
 drivers/bluetooth/hci_qca.c                               | 10 +-
 drivers/bus/mhi/host/pci_generic.c                        |  8 +-
 drivers/char/dtlk.c                                       |  6 +-
 drivers/char/hangcheck-timer.c                            |  2 +-
 drivers/char/hw_random/xgene-rng.c                        |  2 +-
 drivers/char/ipmi/bt-bmc.c                                |  2 +-
 drivers/char/ipmi/ipmi_msghandler.c                       |  2 +-
 drivers/char/ipmi/ipmi_si_intf.c                          |  4 +-
 drivers/char/ipmi/ipmi_ssif.c                             |  6 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                        |  4 +-
 drivers/char/ipmi/ssif_bmc.c                              |  2 +-
 drivers/char/random.c                                     |  2 +-
 drivers/char/tlclk.c                                      |  4 +-
 drivers/char/tpm/tpm-dev-common.c                         |  4 +-
 drivers/comedi/drivers/comedi_test.c                      | 12 +-
 drivers/comedi/drivers/das16.c                            |  4 +-
 drivers/comedi/drivers/jr3_pci.c                          |  2 +-
 drivers/cpufreq/powernv-cpufreq.c                         |  4 +-
 drivers/crypto/axis/artpec6_crypto.c                      |  4 +-
 drivers/dma-buf/st-dma-fence.c                            |  2 +-
 drivers/dma/imx-dma.c                                     |  4 +-
 drivers/dma/ioat/dma.c                                    |  2 +-
 drivers/dma/ioat/init.c                                   |  4 +-
 drivers/firewire/core-transaction.c                       |  2 +-
 drivers/firmware/psci/psci_checker.c                      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                 |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c              |  2 +-
 drivers/gpu/drm/bridge/tda998x_drv.c                      |  2 +-
 drivers/gpu/drm/drm_vblank.c                              |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                  |  2 +-
 drivers/gpu/drm/gud/gud_pipe.c                            |  2 +-
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c      |  6 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                       |  2 +-
 drivers/gpu/drm/i915/gt/mock_engine.c                     |  4 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c              |  4 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c                |  2 +-
 drivers/gpu/drm/i915/i915_utils.c                         |  2 +-
 drivers/gpu/drm/i915/intel_wakeref.c                      |  2 +-
 drivers/gpu/drm/i915/selftests/lib_sw_fence.c             |  2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                         |  2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                     |  2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                 |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                     |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                     |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c                 |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c               |  4 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                         |  2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                              |  2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                         |  2 +-
 drivers/gpu/drm/xe/xe_execlist.c                          |  2 +-
 drivers/greybus/operation.c                               |  2 +-
 drivers/hid/hid-apple.c                                   |  4 +-
 drivers/hid/hid-appleir.c                                 |  2 +-
 drivers/hid/hid-appletb-kbd.c                             |  2 +-
 drivers/hid/hid-magicmouse.c                              |  4 +-
 drivers/hid/hid-multitouch.c                              |  4 +-
 drivers/hid/hid-nvidia-shield.c                           |  2 +-
 drivers/hid/hid-prodikeys.c                               |  2 +-
 drivers/hid/hid-sony.c                                    |  2 +-
 drivers/hid/hid-uclogic-core.c                            |  2 +-
 drivers/hid/hid-wiimote-core.c                            |  2 +-
 drivers/hid/usbhid/hid-core.c                             |  4 +-
 drivers/hid/wacom_sys.c                                   |  2 +-
 drivers/hsi/clients/ssi_protocol.c                        | 18 +--
 drivers/hte/hte-tegra194-test.c                           |  2 +-
 drivers/hwmon/pwm-fan.c                                   |  2 +-
 drivers/i2c/busses/i2c-img-scb.c                          |  2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c                  |  4 +-
 drivers/infiniband/hw/cxgb4/cm.c                          |  2 +-
 drivers/infiniband/hw/hfi1/aspm.c                         |  2 +-
 drivers/infiniband/hw/hfi1/chip.c                         |  4 +-
 drivers/infiniband/hw/hfi1/driver.c                       |  2 +-
 drivers/infiniband/hw/hfi1/init.c                         |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c                         |  2 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c                     |  8 +-
 drivers/infiniband/hw/hfi1/verbs.c                        |  2 +-
 drivers/infiniband/hw/irdma/cm.c                          |  2 +-
 drivers/infiniband/hw/irdma/utils.c                       |  4 +-
 drivers/infiniband/hw/mlx5/mr.c                           |  2 +-
 drivers/infiniband/hw/mthca/mthca_catas.c                 |  2 +-
 drivers/infiniband/hw/qib/qib_driver.c                    |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c                   |  4 +-
 drivers/infiniband/hw/qib/qib_iba7322.c                   |  4 +-
 drivers/infiniband/hw/qib/qib_init.c                      | 10 +-
 drivers/infiniband/hw/qib/qib_mad.c                       |  2 +-
 drivers/infiniband/hw/qib/qib_sd7220.c                    |  2 +-
 drivers/infiniband/hw/qib/qib_verbs.c                     |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c                         |  8 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                        |  4 +-
 drivers/input/ff-memless.c                                |  4 +-
 drivers/input/gameport/gameport.c                         |  4 +-
 drivers/input/input.c                                     |  4 +-
 drivers/input/joystick/db9.c                              |  2 +-
 drivers/input/joystick/gamecon.c                          |  2 +-
 drivers/input/joystick/n64joy.c                           |  2 +-
 drivers/input/joystick/turbografx.c                       |  2 +-
 drivers/input/keyboard/imx_keypad.c                       |  2 +-
 drivers/input/keyboard/snvs_pwrkey.c                      |  2 +-
 drivers/input/keyboard/tegra-kbc.c                        |  4 +-
 drivers/input/mouse/alps.c                                |  2 +-
 drivers/input/mouse/byd.c                                 |  2 +-
 drivers/input/serio/hil_mlc.c                             |  2 +-
 drivers/input/serio/hp_sdc.c                              |  2 +-
 drivers/input/touchscreen/ad7877.c                        |  2 +-
 drivers/input/touchscreen/ad7879.c                        |  2 +-
 drivers/input/touchscreen/bu21029_ts.c                    |  2 +-
 drivers/input/touchscreen/exc3000.c                       |  2 +-
 drivers/input/touchscreen/sx8654.c                        |  2 +-
 drivers/input/touchscreen/tsc200x-core.c                  |  4 +-
 drivers/iommu/dma-iommu.c                                 |  2 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c                    |  6 +-
 drivers/isdn/hardware/mISDN/hfcpci.c                      | 14 +-
 drivers/isdn/hardware/mISDN/mISDNipac.c                   | 10 +-
 drivers/isdn/hardware/mISDN/mISDNisar.c                   |  6 +-
 drivers/isdn/hardware/mISDN/w6692.c                       |  8 +-
 drivers/isdn/mISDN/dsp_core.c                             |  6 +-
 drivers/isdn/mISDN/dsp_tones.c                            |  4 +-
 drivers/isdn/mISDN/fsm.c                                  |  4 +-
 drivers/leds/flash/leds-rt8515.c                          |  4 +-
 drivers/leds/flash/leds-sgm3140.c                         |  6 +-
 drivers/leds/led-core.c                                   |  4 +-
 drivers/leds/trigger/ledtrig-pattern.c                    |  2 +-
 drivers/leds/trigger/ledtrig-transient.c                  |  2 +-
 drivers/macintosh/adbhid.c                                |  2 +-
 drivers/mailbox/mailbox-altera.c                          |  2 +-
 drivers/md/bcache/stats.c                                 |  2 +-
 drivers/md/dm-integrity.c                                 |  4 +-
 drivers/md/dm-mpath.c                                     |  2 +-
 drivers/md/dm-raid1.c                                     |  2 +-
 drivers/md/dm-vdo/dedupe.c                                |  2 +-
 drivers/md/dm-writecache.c                                |  6 +-
 drivers/md/md.c                                           |  4 +-
 drivers/media/common/saa7146/saa7146_fops.c               |  2 +-
 drivers/media/common/saa7146/saa7146_vbi.c                |  4 +-
 drivers/media/common/saa7146/saa7146_video.c              |  2 +-
 drivers/media/dvb-core/dmxdev.c                           |  6 +-
 drivers/media/i2c/tc358743.c                              |  4 +-
 drivers/media/i2c/tvaudio.c                               |  4 +-
 drivers/media/pci/bt8xx/bttv-driver.c                     |  2 +-
 drivers/media/pci/bt8xx/bttv-input.c                      |  4 +-
 drivers/media/pci/bt8xx/bttv-risc.c                       |  2 +-
 drivers/media/pci/ivtv/ivtv-irq.c                         |  6 +-
 drivers/media/pci/ivtv/ivtv-streams.c                     |  4 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c        |  2 +-
 drivers/media/pci/saa7134/saa7134-core.c                  | 10 +-
 drivers/media/pci/saa7134/saa7134-input.c                 |  2 +-
 drivers/media/pci/saa7134/saa7134-ts.c                    |  2 +-
 drivers/media/pci/saa7134/saa7134-vbi.c                   |  2 +-
 drivers/media/pci/saa7134/saa7134-video.c                 |  2 +-
 drivers/media/pci/tw686x/tw686x-core.c                    |  2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c          |  6 +-
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c  |  2 +-
 drivers/media/radio/radio-cadet.c                         |  2 +-
 drivers/media/rc/ene_ir.c                                 |  2 +-
 drivers/media/rc/igorplugusb.c                            |  4 +-
 drivers/media/rc/img-ir/img-ir-hw.c                       |  4 +-
 drivers/media/rc/img-ir/img-ir-raw.c                      |  2 +-
 drivers/media/rc/imon.c                                   |  2 +-
 drivers/media/rc/ir-mce_kbd-decoder.c                     |  4 +-
 drivers/media/rc/rc-ir-raw.c                              |  2 +-
 drivers/media/rc/rc-main.c                                |  6 +-
 drivers/media/rc/serial_ir.c                              |  2 +-
 drivers/media/usb/au0828/au0828-dvb.c                     |  4 +-
 drivers/media/usb/au0828/au0828-video.c                   | 12 +-
 drivers/media/usb/pvrusb2/pvrusb2-encoder.c               |  2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                   | 16 +--
 drivers/memory/tegra/tegra210-emc-core.c                  |  4 +-
 drivers/memstick/core/ms_block.c                          |  4 +-
 drivers/memstick/host/jmb38x_ms.c                         |  2 +-
 drivers/memstick/host/r592.c                              |  4 +-
 drivers/memstick/host/tifm_ms.c                           |  4 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c                          |  4 +-
 drivers/misc/cardreader/rtsx_usb.c                        |  2 +-
 drivers/misc/sgi-xp/xpc_main.c                            |  2 +-
 drivers/misc/sgi-xp/xpc_partition.c                       |  2 +-
 drivers/mmc/core/host.c                                   |  4 +-
 drivers/mmc/host/atmel-mci.c                              |  8 +-
 drivers/mmc/host/dw_mmc.c                                 | 16 +--
 drivers/mmc/host/jz4740_mmc.c                             |  4 +-
 drivers/mmc/host/meson-mx-sdio.c                          |  4 +-
 drivers/mmc/host/mvsdio.c                                 |  4 +-
 drivers/mmc/host/mxcmmc.c                                 |  4 +-
 drivers/mmc/host/omap.c                                   | 10 +-
 drivers/mmc/host/sdhci.c                                  |  8 +-
 drivers/mmc/host/tifm_sd.c                                |  2 +-
 drivers/mmc/host/via-sdmmc.c                              |  4 +-
 drivers/mmc/host/vub300.c                                 |  6 +-
 drivers/mmc/host/wbsd.c                                   |  2 +-
 drivers/most/most_usb.c                                   |  4 +-
 drivers/mtd/sm_ftl.c                                      |  4 +-
 drivers/net/arcnet/arcnet.c                               |  2 +-
 drivers/net/can/grcan.c                                   | 12 +-
 drivers/net/can/kvaser_pciefd.c                           |  6 +-
 drivers/net/can/sja1000/peak_pcmcia.c                     |  2 +-
 drivers/net/dsa/mv88e6xxx/phy.c                           |  4 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c                     |  4 +-
 drivers/net/eql.c                                         |  2 +-
 drivers/net/ethernet/3com/3c515.c                         |  2 +-
 drivers/net/ethernet/3com/3c574_cs.c                      |  2 +-
 drivers/net/ethernet/3com/3c589_cs.c                      |  2 +-
 drivers/net/ethernet/3com/3c59x.c                         |  2 +-
 drivers/net/ethernet/8390/axnet_cs.c                      |  2 +-
 drivers/net/ethernet/8390/pcnet_cs.c                      |  2 +-
 drivers/net/ethernet/agere/et131x.c                       |  2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c              |  6 +-
 drivers/net/ethernet/amd/a2065.c                          |  2 +-
 drivers/net/ethernet/amd/amd8111e.c                       |  4 +-
 drivers/net/ethernet/amd/declance.c                       |  2 +-
 drivers/net/ethernet/amd/pcnet32.c                        |  2 +-
 drivers/net/ethernet/amd/sunlance.c                       |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                  |  4 +-
 drivers/net/ethernet/apple/bmac.c                         |  6 +-
 drivers/net/ethernet/apple/mace.c                         |  4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |  4 +-
 drivers/net/ethernet/atheros/ag71xx.c                     |  2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c           |  2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c           |  2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c                  |  2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c                  |  8 +-
 drivers/net/ethernet/broadcom/b44.c                       |  4 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c              |  6 +-
 drivers/net/ethernet/broadcom/bnx2.c                      | 10 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c           |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c          |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |  2 +-
 drivers/net/ethernet/broadcom/tg3.c                       |  2 +-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c                | 26 ++--
 drivers/net/ethernet/brocade/bna/bnad.c                   | 16 +--
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c                   |  4 +-
 drivers/net/ethernet/chelsio/cxgb3/sge.c                  |  4 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c                  |  4 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c                |  4 +-
 drivers/net/ethernet/cisco/enic/enic_clsf.h               |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c               |  2 +-
 drivers/net/ethernet/dec/tulip/21142.c                    |  4 +-
 drivers/net/ethernet/dec/tulip/de2104x.c                  |  6 +-
 drivers/net/ethernet/dec/tulip/dmfe.c                     |  2 +-
 drivers/net/ethernet/dec/tulip/interrupt.c                |  4 +-
 drivers/net/ethernet/dec/tulip/pnic2.c                    |  6 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c               |  4 +-
 drivers/net/ethernet/dec/tulip/uli526x.c                  |  2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c              |  4 +-
 drivers/net/ethernet/dlink/dl2k.c                         |  4 +-
 drivers/net/ethernet/fealnx.c                             |  4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c             |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c                |  4 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c             |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  2 +-
 drivers/net/ethernet/intel/e100.c                         |  4 +-
 drivers/net/ethernet/intel/e1000e/netdev.c                |  8 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c              |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c               |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c                 |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c        |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c                 |  8 +-
 drivers/net/ethernet/intel/igbvf/netdev.c                 |  4 +-
 drivers/net/ethernet/intel/igc/igc_main.c                 |  8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c             |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c         |  2 +-
 drivers/net/ethernet/korina.c                             |  2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c                |  6 +-
 drivers/net/ethernet/marvell/pxa168_eth.c                 |  2 +-
 drivers/net/ethernet/marvell/skge.c                       |  2 +-
 drivers/net/ethernet/marvell/sky2.c                       |  2 +-
 drivers/net/ethernet/mellanox/mlx4/catas.c                |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c          |  2 +-
 drivers/net/ethernet/micrel/ksz884x.c                     |  2 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c          |  2 +-
 drivers/net/ethernet/natsemi/natsemi.c                    |  4 +-
 drivers/net/ethernet/natsemi/ns83820.c                    |  2 +-
 drivers/net/ethernet/neterion/s2io.c                      |  2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c       |  2 +-
 drivers/net/ethernet/nvidia/forcedeth.c                   |  6 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c      |  2 +-
 drivers/net/ethernet/packetengines/hamachi.c              |  2 +-
 drivers/net/ethernet/packetengines/yellowfin.c            |  2 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c                  |  2 +-
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c       |  2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c                     |  2 +-
 drivers/net/ethernet/realtek/atp.c                        |  2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c                |  2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c           |  6 +-
 drivers/net/ethernet/seeq/ether3.c                        |  6 +-
 drivers/net/ethernet/sfc/falcon/falcon.c                  |  2 +-
 drivers/net/ethernet/sfc/falcon/rx.c                      |  2 +-
 drivers/net/ethernet/sfc/mcdi.c                           |  4 +-
 drivers/net/ethernet/sfc/rx_common.c                      |  2 +-
 drivers/net/ethernet/sfc/siena/mcdi.c                     |  4 +-
 drivers/net/ethernet/sfc/siena/rx_common.c                |  2 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                       |  8 +-
 drivers/net/ethernet/sis/sis190.c                         |  4 +-
 drivers/net/ethernet/sis/sis900.c                         |  2 +-
 drivers/net/ethernet/smsc/epic100.c                       |  2 +-
 drivers/net/ethernet/smsc/smc91c92_cs.c                   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c         |  6 +-
 drivers/net/ethernet/sun/cassini.c                        |  2 +-
 drivers/net/ethernet/sun/ldmvsw.c                         |  6 +-
 drivers/net/ethernet/sun/niu.c                            |  6 +-
 drivers/net/ethernet/sun/sunbmac.c                        |  2 +-
 drivers/net/ethernet/sun/sungem.c                         |  8 +-
 drivers/net/ethernet/sun/sunhme.c                         |  6 +-
 drivers/net/ethernet/sun/sunvnet.c                        |  2 +-
 drivers/net/ethernet/sun/sunvnet_common.c                 |  6 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c            |  2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                        |  2 +-
 drivers/net/ethernet/ti/netcp_ethss.c                     |  2 +-
 drivers/net/ethernet/ti/tlan.c                            |  4 +-
 drivers/net/ethernet/tundra/tsi108_eth.c                  |  2 +-
 drivers/net/fddi/defza.c                                  | 10 +-
 drivers/net/hamradio/6pack.c                              |  6 +-
 drivers/net/hamradio/scc.c                                | 26 ++--
 drivers/net/hamradio/yam.c                                |  2 +-
 drivers/net/hippi/rrunner.c                               |  2 +-
 drivers/net/ntb_netdev.c                                  |  2 +-
 drivers/net/phy/phylink.c                                 |  4 +-
 drivers/net/slip/slip.c                                   | 14 +-
 drivers/net/tun.c                                         |  2 +-
 drivers/net/usb/catc.c                                    |  2 +-
 drivers/net/usb/lan78xx.c                                 |  6 +-
 drivers/net/usb/sierra_net.c                              |  2 +-
 drivers/net/usb/usbnet.c                                  |  6 +-
 drivers/net/vxlan/vxlan_core.c                            |  2 +-
 drivers/net/wan/hdlc_cisco.c                              |  2 +-
 drivers/net/wan/hdlc_fr.c                                 |  2 +-
 drivers/net/wan/hdlc_ppp.c                                |  2 +-
 drivers/net/wireguard/device.c                            |  2 +-
 drivers/net/wireguard/timers.c                            |  8 +-
 drivers/net/wireless/ath/ar5523/ar5523.c                  |  4 +-
 drivers/net/wireless/ath/ath10k/debug.c                   |  2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c                  |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c                     |  4 +-
 drivers/net/wireless/ath/ath10k/sdio.c                    |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c                    |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.c                     |  2 +-
 drivers/net/wireless/ath/ath11k/dp.c                      |  4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c                   |  8 +-
 drivers/net/wireless/ath/ath12k/dp.c                      |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c                   |  4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c                |  6 +-
 drivers/net/wireless/ath/ath6kl/init.c                    |  2 +-
 drivers/net/wireless/ath/ath6kl/main.c                    |  2 +-
 drivers/net/wireless/ath/ath6kl/recovery.c                |  4 +-
 drivers/net/wireless/ath/ath6kl/txrx.c                    |  2 +-
 drivers/net/wireless/ath/ath9k/channel.c                  |  2 +-
 drivers/net/wireless/ath/ath9k/gpio.c                     |  8 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c             |  6 +-
 drivers/net/wireless/ath/ath9k/init.c                     |  2 +-
 drivers/net/wireless/ath/ath9k/link.c                     |  2 +-
 drivers/net/wireless/ath/ath9k/main.c                     | 10 +-
 drivers/net/wireless/ath/ath9k/pci.c                      |  2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c                    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c               |  2 +-
 drivers/net/wireless/ath/wil6210/main.c                   |  6 +-
 drivers/net/wireless/ath/wil6210/netdev.c                 |  6 +-
 drivers/net/wireless/ath/wil6210/p2p.c                    |  2 +-
 drivers/net/wireless/ath/wil6210/wmi.c                    |  6 +-
 drivers/net/wireless/atmel/at76c50x-usb.c                 |  2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c |  4 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   |  2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |  2 +-
 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c        |  2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c            |  2 +-
 drivers/net/wireless/intel/iwlegacy/3945-rs.c             |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c            |  4 +-
 drivers/net/wireless/intel/iwlegacy/common.c              |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c          |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c             |  4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c               | 10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c              |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c              |  6 +-
 drivers/net/wireless/marvell/libertas/cmdresp.c           |  2 +-
 drivers/net/wireless/marvell/libertas/if_usb.c            |  2 +-
 drivers/net/wireless/marvell/libertas/main.c              | 12 +-
 drivers/net/wireless/marvell/libertas_tf/cmd.c            |  2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c         |  2 +-
 drivers/net/wireless/marvell/libertas_tf/main.c           |  4 +-
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c      |  2 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c             |  2 +-
 drivers/net/wireless/marvell/mwifiex/init.c               |  4 +-
 drivers/net/wireless/marvell/mwifiex/main.c               |  2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c               |  4 +-
 drivers/net/wireless/marvell/mwifiex/sta_event.c          |  4 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c               |  2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c                |  6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c          |  4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c       |  4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c           |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c          |  6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c          |  4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c          |  2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c             | 18 +--
 drivers/net/wireless/purelifi/plfxlc/usb.c                |  4 +-
 drivers/net/wireless/realtek/rtlwifi/base.c               |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c       |  4 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c                    |  4 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c               |  6 +-
 drivers/net/wireless/st/cw1200/main.c                     |  2 +-
 drivers/net/wireless/st/cw1200/pm.c                       |  2 +-
 drivers/net/wireless/st/cw1200/queue.c                    |  2 +-
 drivers/net/wireless/st/cw1200/sta.c                      |  6 +-
 drivers/net/wireless/ti/wlcore/main.c                     |  4 +-
 drivers/net/xen-netback/interface.c                       |  2 +-
 drivers/net/xen-netfront.c                                |  2 +-
 drivers/nfc/nfcmrvl/fw_dnld.c                             |  6 +-
 drivers/nfc/pn533/pn533.c                                 |  4 +-
 drivers/nfc/pn533/uart.c                                  |  2 +-
 drivers/nfc/st-nci/ndlc.c                                 | 12 +-
 drivers/nfc/st-nci/se.c                                   | 10 +-
 drivers/nfc/st21nfca/core.c                               |  4 +-
 drivers/nfc/st21nfca/se.c                                 |  6 +-
 drivers/nvme/host/multipath.c                             |  4 +-
 drivers/parport/ieee1284.c                                |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                         |  2 +-
 drivers/pci/hotplug/shpchp_hpc.c                          |  2 +-
 drivers/pcmcia/i82365.c                                   |  2 +-
 drivers/pcmcia/soc_common.c                               |  4 +-
 drivers/pcmcia/tcic.c                                     |  2 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c                  |  2 +-
 drivers/platform/x86/intel_ips.c                          |  2 +-
 drivers/platform/x86/sony-laptop.c                        |  2 +-
 drivers/pps/clients/pps-gpio.c                            |  2 +-
 drivers/pps/clients/pps-ktimer.c                          |  2 +-
 drivers/pps/generators/pps_gen-dummy.c                    |  4 +-
 drivers/ptp/ptp_ocp.c                                     |  2 +-
 drivers/rtc/dev.c                                         |  2 +-
 drivers/rtc/rtc-test.c                                    |  4 +-
 drivers/s390/block/dasd.c                                 |  8 +-
 drivers/s390/char/con3270.c                               |  4 +-
 drivers/s390/char/sclp.c                                  | 12 +-
 drivers/s390/char/sclp_con.c                              |  2 +-
 drivers/s390/char/sclp_vt220.c                            |  4 +-
 drivers/s390/char/tape_core.c                             |  2 +-
 drivers/s390/char/tape_std.c                              |  2 +-
 drivers/s390/cio/device_fsm.c                             |  2 +-
 drivers/s390/cio/eadm_sch.c                               |  2 +-
 drivers/s390/crypto/ap_queue.c                            |  2 +-
 drivers/s390/net/fsm.c                                    |  4 +-
 drivers/s390/net/qeth_core_main.c                         |  2 +-
 drivers/s390/scsi/zfcp_fsf.c                              |  4 +-
 drivers/s390/scsi/zfcp_qdio.c                             |  2 +-
 drivers/scsi/aic7xxx/aic79xx_core.c                       |  4 +-
 drivers/scsi/aic94xx/aic94xx_hwi.c                        |  2 +-
 drivers/scsi/aic94xx/aic94xx_init.c                       |  2 +-
 drivers/scsi/aic94xx/aic94xx_tmf.c                        |  6 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                          | 20 +--
 drivers/scsi/arm/fas216.c                                 |  6 +-
 drivers/scsi/be2iscsi/be_main.c                           |  4 +-
 drivers/scsi/bfa/bfad.c                                   | 10 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                         |  4 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                          |  4 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                          |  8 +-
 drivers/scsi/csiostor/csio_hw.c                           |  4 +-
 drivers/scsi/csiostor/csio_mb.c                           |  4 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                        |  2 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                        |  2 +-
 drivers/scsi/dc395x.c                                     | 12 +-
 drivers/scsi/elx/efct/efct_driver.c                       |  2 +-
 drivers/scsi/elx/efct/efct_xport.c                        |  2 +-
 drivers/scsi/elx/libefc/efc_fabric.c                      |  2 +-
 drivers/scsi/elx/libefc/efc_node.c                        |  2 +-
 drivers/scsi/esas2r/esas2r_init.c                         |  2 +-
 drivers/scsi/fcoe/fcoe.c                                  |  2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                             |  4 +-
 drivers/scsi/fnic/fdls_disc.c                             | 12 +-
 drivers/scsi/fnic/fip.c                                   | 12 +-
 drivers/scsi/fnic/fnic_main.c                             | 12 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c                     |  6 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                    | 14 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                    |  4 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                            | 16 +--
 drivers/scsi/ibmvscsi/ibmvscsi.c                          |  6 +-
 drivers/scsi/ipr.c                                        | 12 +-
 drivers/scsi/isci/host.c                                  | 12 +-
 drivers/scsi/isci/isci.h                                  |  8 +-
 drivers/scsi/libfc/fc_fcp.c                               |  4 +-
 drivers/scsi/libiscsi.c                                   |  6 +-
 drivers/scsi/libsas/sas_expander.c                        |  2 +-
 drivers/scsi/libsas/sas_scsi_host.c                       |  8 +-
 drivers/scsi/lpfc/lpfc_attr.c                             |  2 +-
 drivers/scsi/lpfc/lpfc_els.c                              |  4 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                          |  8 +-
 drivers/scsi/lpfc/lpfc_init.c                             | 20 +--
 drivers/scsi/lpfc/lpfc_scsi.c                             |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c                              | 10 +-
 drivers/scsi/megaraid/megaraid_mbox.c                     |  2 +-
 drivers/scsi/megaraid/megaraid_mm.c                       |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c                 | 10 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c               |  2 +-
 drivers/scsi/mvsas/mv_sas.c                               |  2 +-
 drivers/scsi/pmcraid.c                                    |  6 +-
 drivers/scsi/qla1280.c                                    |  2 +-
 drivers/scsi/qla2xxx/qla_init.c                           |  2 +-
 drivers/scsi/qla2xxx/qla_iocb.c                           |  4 +-
 drivers/scsi/qla2xxx/qla_mid.c                            |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                             |  2 +-
 drivers/scsi/qla4xxx/ql4_os.c                             |  2 +-
 drivers/scsi/smartpqi/smartpqi_init.c                     |  2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c                       |  2 +-
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c      |  4 +-
 drivers/staging/gpib/common/gpib_os.c                     |  4 +-
 drivers/staging/gpib/common/iblib.c                       |  2 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c                 |  8 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c               |  2 +-
 drivers/staging/media/imx/imx-media-csi.c                 |  2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c                  |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c                 |  4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c             | 22 ++--
 drivers/staging/rtl8723bs/core/rtw_recv.c                 |  2 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c              |  6 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c                  |  2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c               | 12 +-
 drivers/target/iscsi/iscsi_target_erl0.c                  |  2 +-
 drivers/target/iscsi/iscsi_target_erl1.c                  |  2 +-
 drivers/target/iscsi/iscsi_target_util.c                  |  4 +-
 drivers/target/target_core_user.c                         |  8 +-
 drivers/tty/ipwireless/hardware.c                         |  4 +-
 drivers/tty/mips_ejtag_fdc.c                              |  4 +-
 drivers/tty/moxa.c                                        |  2 +-
 drivers/tty/n_gsm.c                                       | 14 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c               |  2 +-
 drivers/tty/serial/8250/8250_core.c                       |  2 +-
 drivers/tty/serial/altera_uart.c                          |  2 +-
 drivers/tty/serial/amba-pl011.c                           |  4 +-
 drivers/tty/serial/atmel_serial.c                         |  2 +-
 drivers/tty/serial/fsl_lpuart.c                           |  6 +-
 drivers/tty/serial/imx.c                                  |  4 +-
 drivers/tty/serial/liteuart.c                             |  4 +-
 drivers/tty/serial/max3100.c                              |  4 +-
 drivers/tty/serial/mux.c                                  |  2 +-
 drivers/tty/serial/sa1100.c                               |  4 +-
 drivers/tty/serial/sccnxp.c                               |  2 +-
 drivers/tty/serial/sh-sci.c                               |  2 +-
 drivers/tty/synclink_gt.c                                 |  8 +-
 drivers/tty/sysrq.c                                       |  4 +-
 drivers/tty/vcc.c                                         |  6 +-
 drivers/tty/vt/keyboard.c                                 |  2 +-
 drivers/tty/vt/vt.c                                       |  4 +-
 drivers/usb/atm/cxacru.c                                  |  2 +-
 drivers/usb/atm/speedtch.c                                |  8 +-
 drivers/usb/atm/usbatm.c                                  |  4 +-
 drivers/usb/core/hcd.c                                    |  6 +-
 drivers/usb/core/hub.c                                    |  2 +-
 drivers/usb/dwc2/hcd.c                                    |  2 +-
 drivers/usb/dwc2/hcd_queue.c                              |  4 +-
 drivers/usb/gadget/legacy/zero.c                          |  4 +-
 drivers/usb/gadget/udc/omap_udc.c                         |  2 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                       |  8 +-
 drivers/usb/gadget/udc/r8a66597-udc.c                     |  2 +-
 drivers/usb/gadget/udc/snps_udc_core.c                    |  4 +-
 drivers/usb/host/ehci-platform.c                          |  2 +-
 drivers/usb/host/isp1362-hcd.c                            |  2 +-
 drivers/usb/host/ohci-hcd.c                               |  2 +-
 drivers/usb/host/ohci-hub.c                               |  2 +-
 drivers/usb/host/oxu210hp-hcd.c                           |  6 +-
 drivers/usb/host/r8a66597-hcd.c                           |  2 +-
 drivers/usb/host/sl811-hcd.c                              |  2 +-
 drivers/usb/host/uhci-hcd.c                               |  2 +-
 drivers/usb/host/uhci-q.c                                 |  2 +-
 drivers/usb/host/xen-hcd.c                                |  4 +-
 drivers/usb/host/xhci-hub.c                               |  2 +-
 drivers/usb/host/xhci-mtk.c                               |  4 +-
 drivers/usb/host/xhci.c                                   | 14 +-
 drivers/usb/isp1760/isp1760-hcd.c                         |  2 +-
 drivers/usb/isp1760/isp1760-udc.c                         |  4 +-
 drivers/usb/misc/usbtest.c                                |  2 +-
 drivers/usb/musb/da8xx.c                                  |  6 +-
 drivers/usb/musb/mpfs.c                                   |  4 +-
 drivers/usb/musb/musb_core.c                              |  4 +-
 drivers/usb/musb/musb_dsps.c                              |  8 +-
 drivers/usb/musb/tusb6010.c                               |  8 +-
 drivers/usb/phy/phy-mv-usb.c                              |  2 +-
 drivers/usb/storage/realtek_cr.c                          |  2 +-
 drivers/video/fbdev/aty/radeon_backlight.c                |  2 +-
 drivers/video/fbdev/aty/radeon_base.c                     |  4 +-
 drivers/video/fbdev/aty/radeon_pm.c                       |  2 +-
 drivers/video/fbdev/omap/hwa742.c                         |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                |  2 +-
 drivers/virt/vboxguest/vboxguest_core.c                   |  2 +-
 drivers/watchdog/alim7101_wdt.c                           |  4 +-
 drivers/watchdog/at91sam9_wdt.c                           |  4 +-
 drivers/watchdog/bcm47xx_wdt.c                            |  4 +-
 drivers/watchdog/cpwd.c                                   |  4 +-
 drivers/watchdog/lpc18xx_wdt.c                            |  4 +-
 drivers/watchdog/machzwd.c                                |  4 +-
 drivers/watchdog/mixcomwd.c                               |  4 +-
 drivers/watchdog/pcwd.c                                   |  2 +-
 drivers/watchdog/pika_wdt.c                               |  2 +-
 drivers/watchdog/sbc60xxwdt.c                             |  4 +-
 drivers/watchdog/sc520_wdt.c                              |  2 +-
 drivers/watchdog/shwdt.c                                  |  2 +-
 drivers/watchdog/via_wdt.c                                |  2 +-
 drivers/watchdog/w83877f_wdt.c                            |  4 +-
 fs/afs/fs_probe.c                                         |  2 +-
 fs/afs/server.c                                           |  2 +-
 fs/bcachefs/clock.c                                       |  2 +-
 fs/btrfs/zstd.c                                           |  2 +-
 fs/ext4/super.c                                           |  2 +-
 fs/jbd2/journal.c                                         |  4 +-
 fs/jffs2/wbuf.c                                           |  2 +-
 fs/nilfs2/segment.c                                       |  2 +-
 fs/ocfs2/cluster/tcp.c                                    |  2 +-
 fs/pstore/platform.c                                      |  2 +-
 include/linux/timer.h                                     | 36 +------
 include/net/sctp/sctp.h                                   |  2 +-
 kernel/cgroup/cgroup.c                                    |  2 +-
 kernel/kcsan/kcsan_test.c                                 |  2 +-
 kernel/kthread.c                                          |  4 +-
 kernel/rcu/rcutorture.c                                   |  2 +-
 kernel/rcu/srcutree.c                                     |  2 +-
 kernel/rcu/tasks.h                                        |  2 +-
 kernel/rcu/tree_nocb.h                                    |  4 +-
 kernel/sched/psi.c                                        |  2 +-
 kernel/time/clocksource.c                                 |  2 +-
 kernel/time/hrtimer.c                                     |  2 +-
 kernel/time/sleep_timeout.c                               |  2 +-
 kernel/time/timer.c                                       |  8 +-
 kernel/workqueue.c                                        | 14 +-
 mm/backing-dev.c                                          |  2 +-
 mm/page-writeback.c                                       |  4 +-
 net/appletalk/aarp.c                                      |  4 +-
 net/atm/clip.c                                            |  2 +-
 net/atm/lec.c                                             | 26 ++--
 net/atm/mpc.c                                             |  4 +-
 net/ax25/af_ax25.c                                        | 10 +-
 net/ax25/ax25_ds_timer.c                                  |  2 +-
 net/ax25/ax25_subr.c                                      | 10 +-
 net/ax25/ax25_timer.c                                     | 14 +-
 net/batman-adv/tp_meter.c                                 |  6 +-
 net/bluetooth/hidp/core.c                                 |  2 +-
 net/bluetooth/rfcomm/core.c                               |  4 +-
 net/bridge/br_mdb.c                                       |  6 +-
 net/bridge/br_multicast.c                                 | 44 +++----
 net/bridge/br_stp.c                                       | 14 +-
 net/bridge/br_stp_if.c                                    | 12 +-
 net/can/af_can.c                                          |  2 +-
 net/core/drop_monitor.c                                   |  8 +-
 net/core/gen_estimator.c                                  |  2 +-
 net/core/neighbour.c                                      | 10 +-
 net/core/sock.c                                           |  4 +-
 net/ipv4/igmp.c                                           | 10 +-
 net/ipv4/inet_fragment.c                                  |  6 +-
 net/ipv4/ipmr.c                                           |  2 +-
 net/ipv6/addrconf.c                                       |  2 +-
 net/ipv6/ip6_fib.c                                        |  4 +-
 net/ipv6/ip6_flowlabel.c                                  |  2 +-
 net/ipv6/ip6mr.c                                          |  2 +-
 net/lapb/lapb_iface.c                                     |  4 +-
 net/lapb/lapb_timer.c                                     |  8 +-
 net/llc/llc_c_ac.c                                        | 18 +--
 net/llc/llc_conn.c                                        | 16 +--
 net/mac80211/agg-rx.c                                     |  4 +-
 net/mac80211/agg-tx.c                                     |  6 +-
 net/mac80211/ibss.c                                       |  2 +-
 net/mac80211/iface.c                                      |  2 +-
 net/mac80211/led.c                                        |  2 +-
 net/mac80211/mesh.c                                       |  8 +-
 net/mac80211/mesh_plink.c                                 | 12 +-
 net/mac80211/mlme.c                                       | 16 +--
 net/mac80211/ocb.c                                        |  2 +-
 net/mac80211/offchannel.c                                 |  6 +-
 net/mac80211/pm.c                                         |  4 +-
 net/mac80211/rx.c                                         |  2 +-
 net/mac80211/sta_info.c                                   |  2 +-
 net/mctp/af_mctp.c                                        |  2 +-
 net/mptcp/pm.c                                            |  2 +-
 net/ncsi/ncsi-manage.c                                    |  4 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h                   |  2 +-
 net/netfilter/ipvs/ip_vs_conn.c                           |  6 +-
 net/netfilter/ipvs/ip_vs_ctl.c                            |  2 +-
 net/netfilter/nf_conntrack_expect.c                       | 10 +-
 net/netfilter/nf_conntrack_netlink.c                      |  4 +-
 net/netfilter/nfnetlink_log.c                             |  2 +-
 net/netrom/nr_loopback.c                                  |  2 +-
 net/nfc/core.c                                            |  6 +-
 net/nfc/hci/core.c                                        |  4 +-
 net/nfc/hci/llc_shdlc.c                                   |  8 +-
 net/nfc/llcp_core.c                                       |  6 +-
 net/nfc/nci/core.c                                        |  6 +-
 net/nfc/nci/data.c                                        |  2 +-
 net/nfc/nci/rsp.c                                         |  2 +-
 net/packet/af_packet.c                                    |  2 +-
 net/rose/rose_link.c                                      |  8 +-
 net/rose/rose_loopback.c                                  |  2 +-
 net/rose/rose_route.c                                     |  4 +-
 net/rxrpc/call_event.c                                    |  2 +-
 net/rxrpc/call_object.c                                   |  4 +-
 net/rxrpc/conn_client.c                                   |  2 +-
 net/rxrpc/conn_object.c                                   |  8 +-
 net/rxrpc/net_ns.c                                        |  4 +-
 net/sched/sch_fq_pie.c                                    |  2 +-
 net/sched/sch_generic.c                                   |  2 +-
 net/sched/sch_pie.c                                       |  2 +-
 net/sched/sch_red.c                                       |  4 +-
 net/sched/sch_sfq.c                                       |  4 +-
 net/sctp/associola.c                                      |  4 +-
 net/sctp/input.c                                          |  2 +-
 net/sctp/output.c                                         |  2 +-
 net/sctp/outqueue.c                                       |  5 +-
 net/sctp/protocol.c                                       |  2 +-
 net/sctp/sm_sideeffect.c                                  |  6 +-
 net/sctp/stream.c                                         |  6 +-
 net/sctp/transport.c                                      | 12 +-
 net/sunrpc/xprt.c                                         |  4 +-
 net/tipc/node.c                                           |  2 +-
 net/tipc/subscr.c                                         |  2 +-
 net/wireless/core.c                                       |  6 +-
 net/x25/x25_link.c                                        |  2 +-
 net/x25/x25_timer.c                                       |  4 +-
 net/xfrm/xfrm_policy.c                                    | 10 +-
 net/xfrm/xfrm_state.c                                     |  2 +-
 samples/connector/cn_test.c                               |  2 +-
 samples/ftrace/sample-trace-array.c                       |  2 +-
 sound/core/timer.c                                        |  4 +-
 sound/drivers/aloop.c                                     |  4 +-
 sound/drivers/dummy.c                                     |  2 +-
 sound/drivers/mpu401/mpu401_uart.c                        |  2 +-
 sound/drivers/mtpav.c                                     |  2 +-
 sound/drivers/opl3/opl3_seq.c                             |  2 +-
 sound/drivers/serial-u16550.c                             |  2 +-
 sound/i2c/other/ak4117.c                                  |  2 +-
 sound/isa/sb/emu8000_pcm.c                                |  2 +-
 sound/isa/sb/sb8_midi.c                                   |  4 +-
 sound/isa/wavefront/wavefront_midi.c                      |  4 +-
 sound/pci/asihpi/asihpi.c                                 |  2 +-
 sound/pci/ctxfi/cttimer.c                                 |  2 +-
 sound/pci/echoaudio/midi.c                                |  2 +-
 sound/pci/rme9652/hdsp.c                                  |  2 +-
 sound/pci/rme9652/hdspm.c                                 |  2 +-
 sound/sh/aica.c                                           |  2 +-
 sound/soc/codecs/rt5645.c                                 |  4 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                             |  4 +-
 sound/soc/ti/ams-delta.c                                  |  2 +-
 sound/usb/midi.c                                          |  2 +-
 787 files changed, 1613 insertions(+), 1648 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index b9cd364..a89ce84 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -177,7 +177,7 @@ srmcons_close(struct tty_struct *tty, struct file *filp)
 
 	if (tty->count == 1) {
 		port->tty = NULL;
-		del_timer(&srmconsp->timer);
+		timer_delete(&srmconsp->timer);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index f8920d0..6521ab3 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -135,7 +135,7 @@ static struct timer_list perr_timer;
 
 static void dc21285_enable_error(struct timer_list *timer)
 {
-	del_timer(timer);
+	timer_delete(timer);
 
 	if (timer == &serr_timer)
 		enable_irq(IRQ_PCI_SERR);
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index dd930e3..71b282b 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -913,8 +913,8 @@ static void sharpsl_pm_remove(struct platform_device *pdev)
 	if (sharpsl_pm.machinfo->exit)
 		sharpsl_pm.machinfo->exit();
 
-	del_timer_sync(&sharpsl_pm.chrg_full_timer);
-	del_timer_sync(&sharpsl_pm.ac_timer);
+	timer_delete_sync(&sharpsl_pm.chrg_full_timer);
+	timer_delete_sync(&sharpsl_pm.ac_timer);
 }
 
 static struct platform_driver sharpsl_pm_driver = {
diff --git a/arch/m68k/amiga/amisound.c b/arch/m68k/amiga/amisound.c
index 714fe8e..5fd93df 100644
--- a/arch/m68k/amiga/amisound.c
+++ b/arch/m68k/amiga/amisound.c
@@ -78,7 +78,7 @@ void amiga_mksound( unsigned int hz, unsigned int ticks )
 		return;
 
 	local_irq_save(flags);
-	del_timer( &sound_timer );
+	timer_delete(&sound_timer);
 
 	if (hz > 20 && hz < 32767) {
 		unsigned long period = (clock_constant / hz);
diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index faea226..6312d5b 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -183,7 +183,7 @@ void mac_mksound( unsigned int freq, unsigned int length )
 
 	local_irq_save(flags);
 
-	del_timer( &mac_sound_timer );
+	timer_delete(&mac_sound_timer);
 
 	for ( i = 0; i < 0x800; i++ )
 		mac_asc_regs[ i ] = 0;
@@ -277,7 +277,7 @@ static void mac_quadra_ring_bell(struct timer_list *unused)
 
 	local_irq_save(flags);
 
-	del_timer( &mac_sound_timer );
+	timer_delete(&mac_sound_timer);
 
 	if ( mac_bell_duration-- > 0 )
 	{
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 8f0861c..8539f56 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -98,7 +98,7 @@ static void blink_timeout(struct timer_list *unused)
 
 static void debounce(struct timer_list *unused)
 {
-	del_timer(&debounce_timer);
+	timer_delete(&debounce_timer);
 	if (sgint->istat1 & SGINT_ISTAT1_PWR) {
 		/* Interrupt still being sent. */
 		debounce_timer.expires = jiffies + (HZ / 20); /* 0.05s	*/
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6a5be02..6a48059 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -622,7 +622,7 @@ static void arm_next_watchdog(struct kvm_vcpu *vcpu)
 	if (nr_jiffies < NEXT_TIMER_MAX_DELTA)
 		mod_timer(&vcpu->arch.wdt_timer, jiffies + nr_jiffies);
 	else
-		del_timer(&vcpu->arch.wdt_timer);
+		timer_delete(&vcpu->arch.wdt_timer);
 	spin_unlock_irqrestore(&vcpu->arch.wdt_lock, flags);
 }
 
@@ -1441,7 +1441,7 @@ int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu)
 
 void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
-	del_timer_sync(&vcpu->arch.wdt_timer);
+	timer_delete_sync(&vcpu->arch.wdt_timer);
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 610ca85..8e7ed01 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -508,7 +508,7 @@ static void __spu_del_from_rq(struct spu_context *ctx)
 
 	if (!list_empty(&ctx->rq)) {
 		if (!--spu_prio->nr_waiting)
-			del_timer(&spusched_timer);
+			timer_delete(&spusched_timer);
 		list_del_init(&ctx->rq);
 
 		if (list_empty(&spu_prio->runq[prio]))
@@ -1126,8 +1126,8 @@ void spu_sched_exit(void)
 
 	remove_proc_entry("spu_loadavg", NULL);
 
-	del_timer_sync(&spusched_timer);
-	del_timer_sync(&spuloadavg_timer);
+	timer_delete_sync(&spusched_timer);
+	timer_delete_sync(&spuloadavg_timer);
 	kthread_stop(spusched_task);
 
 	for (node = 0; node < MAX_NUMNODES; node++) {
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index c097d59..a0ae586 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -347,7 +347,7 @@ static irqreturn_t kw_i2c_irq(int irq, void *dev_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	del_timer(&host->timeout_timer);
+	timer_delete(&host->timeout_timer);
 	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
 	if (host->state != state_idle) {
 		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index c900ded..fed17d4 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -680,7 +680,7 @@ static void stp_work_fn(struct work_struct *work)
 
 	if (!stp_online) {
 		chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000, NULL);
-		del_timer_sync(&stp_timer);
+		timer_delete_sync(&stp_timer);
 		goto out_unlock;
 	}
 
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 39f44b6..e2a6eb9 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -201,7 +201,7 @@ static void cmm_set_timer(void)
 {
 	if (cmm_timed_pages_target <= 0 || cmm_timeout_seconds <= 0) {
 		if (timer_pending(&cmm_timer))
-			del_timer(&cmm_timer);
+			timer_delete(&cmm_timer);
 		return;
 	}
 	mod_timer(&cmm_timer, jiffies + secs_to_jiffies(cmm_timeout_seconds));
@@ -424,7 +424,7 @@ out_smsg:
 #endif
 	unregister_sysctl_table(cmm_sysctl_header);
 out_sysctl:
-	del_timer_sync(&cmm_timer);
+	timer_delete_sync(&cmm_timer);
 	return rc;
 }
 module_init(cmm_init);
@@ -437,7 +437,7 @@ static void __exit cmm_exit(void)
 #endif
 	unregister_oom_notifier(&cmm_oom_nb);
 	kthread_stop(cmm_thread_ptr);
-	del_timer_sync(&cmm_timer);
+	timer_delete_sync(&cmm_timer);
 	cmm_free_pages(cmm_pages, &cmm_pages, &cmm_page_list);
 	cmm_free_pages(cmm_timed_pages, &cmm_timed_pages, &cmm_timed_page_list);
 }
diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index ab9e791..5442475 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -90,7 +90,7 @@ static void pcibios_enable_err(struct timer_list *t)
 {
 	struct pci_channel *hose = from_timer(hose, t, err_timer);
 
-	del_timer(&hose->err_timer);
+	timer_delete(&hose->err_timer);
 	printk(KERN_DEBUG "PCI: re-enabling error IRQ.\n");
 	enable_irq(hose->err_irq);
 }
@@ -99,7 +99,7 @@ static void pcibios_enable_serr(struct timer_list *t)
 {
 	struct pci_channel *hose = from_timer(hose, t, serr_timer);
 
-	del_timer(&hose->serr_timer);
+	timer_delete(&hose->serr_timer);
 	printk(KERN_DEBUG "PCI: re-enabling system error IRQ.\n");
 	enable_irq(hose->serr_irq);
 }
diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index ab657b3..f4fb82b 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -84,7 +84,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 	/* before we change anything we want to stop any running timers,
 	 * otherwise calls such as on will have no persistent effect
 	 */
-	del_timer_sync(&led_blink_timer);
+	timer_delete_sync(&led_blink_timer);
 
 	if (!strcmp(buf, "on")) {
 		auxio_set_led(AUXIO_LED_ON);
@@ -134,7 +134,7 @@ static int __init led_init(void)
 static void __exit led_exit(void)
 {
 	remove_proc_entry("led", NULL);
-	del_timer_sync(&led_blink_timer);
+	timer_delete_sync(&led_blink_timer);
 }
 
 module_init(led_init);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 85b129e..b97bb52 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1112,7 +1112,7 @@ static int vector_net_close(struct net_device *dev)
 	struct vector_private *vp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	del_timer(&vp->tl);
+	timer_delete(&vp->tl);
 
 	vp->opened = false;
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1f14c33..f6fd71b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1786,13 +1786,13 @@ void mce_timer_kick(bool storm)
 		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
-/* Must not be called in IRQ context where del_timer_sync() can deadlock */
+/* Must not be called in IRQ context where timer_delete_sync() can deadlock */
 static void mce_timer_delete_all(void)
 {
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		del_timer_sync(&per_cpu(mce_timer, cpu));
+		timer_delete_sync(&per_cpu(mce_timer, cpu));
 }
 
 static void __mcheck_cpu_mce_banks_init(void)
@@ -2820,7 +2820,7 @@ static int mce_cpu_pre_down(unsigned int cpu)
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
 	mce_disable_cpu();
-	del_timer_sync(t);
+	timer_delete_sync(t);
 	mce_threshold_remove_device(cpu);
 	mce_device_remove(cpu);
 	return 0;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index bd21e9c..38b33cd 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1553,7 +1553,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 		kvm_vcpu_halt(vcpu);
 
 		if (sched_poll.timeout)
-			del_timer(&vcpu->arch.xen.poll_timer);
+			timer_delete(&vcpu->arch.xen.poll_timer);
 
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	}
@@ -2308,7 +2308,7 @@ void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
 	kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_info_cache);
 	kvm_gpc_deactivate(&vcpu->arch.xen.vcpu_time_info_cache);
 
-	del_timer_sync(&vcpu->arch.xen.poll_timer);
+	timer_delete_sync(&vcpu->arch.xen.poll_timer);
 }
 
 void kvm_xen_init_vm(struct kvm *kvm)
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index abec44b..8b95221 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -48,7 +48,7 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
 	if (tty->count == 1)
-		del_timer_sync(&serial_timer);
+		timer_delete_sync(&serial_timer);
 }
 
 
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index e89f27f..c6d8c62 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -375,7 +375,7 @@ static int iss_net_close(struct net_device *dev)
 	struct iss_net_private *lp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->timer);
+	timer_delete_sync(&lp->timer);
 	lp->tp.net_ops->close(lp);
 
 	return 0;
diff --git a/block/blk-core.c b/block/blk-core.c
index 4623de7..e8cc270 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -219,7 +219,7 @@ EXPORT_SYMBOL_GPL(blk_status_to_str);
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	del_timer_sync(&q->timeout);
+	timer_delete_sync(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
 }
 EXPORT_SYMBOL(blk_sync_queue);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index eaf6009..46449da 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -162,7 +162,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 
-	del_timer_sync(&cb->timer);
+	timer_delete_sync(&cb->timer);
 }
 
 static void blk_stat_free_callback_rcu(struct rcu_head *head)
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 5d7f18b..9e05bf1 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -148,7 +148,7 @@ static inline void blk_stat_activate_nsecs(struct blk_stat_callback *cb,
 
 static inline void blk_stat_deactivate(struct blk_stat_callback *cb)
 {
-	del_timer_sync(&cb->timer);
+	timer_delete_sync(&cb->timer);
 }
 
 /**
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91dab43..d6dd2e0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -333,7 +333,7 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 
-	del_timer_sync(&tg->service_queue.pending_timer);
+	timer_delete_sync(&tg->service_queue.pending_timer);
 	blkg_rwstat_exit(&tg->stat_bytes);
 	blkg_rwstat_exit(&tg->stat_ios);
 	kfree(tg);
@@ -1711,7 +1711,7 @@ void blk_throtl_exit(struct gendisk *disk)
 	if (!blk_throtl_activated(q))
 		return;
 
-	del_timer_sync(&q->td->service_queue.pending_timer);
+	timer_delete_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(disk, &blkcg_policy_throtl);
 	kfree(q->td);
diff --git a/drivers/accel/qaic/qaic_timesync.c b/drivers/accel/qaic/qaic_timesync.c
index 2473c66..972833f 100644
--- a/drivers/accel/qaic/qaic_timesync.c
+++ b/drivers/accel/qaic/qaic_timesync.c
@@ -221,7 +221,7 @@ static void qaic_timesync_remove(struct mhi_device *mhi_dev)
 {
 	struct mqts_dev *mqtsdev = dev_get_drvdata(&mhi_dev->dev);
 
-	del_timer_sync(&mqtsdev->timer);
+	timer_delete_sync(&mqtsdev->timer);
 	mhi_unprepare_from_transfer(mqtsdev->mhi_dev);
 	kfree(mqtsdev->sync_msg);
 	kfree(mqtsdev);
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index f677ad2..e68cf1d 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1172,13 +1172,13 @@ static void do_handle_shift(struct vc_data *vc, u_char value, char up_flag)
 	if (cursor_track == read_all_mode) {
 		switch (value) {
 		case KVAL(K_SHIFT):
-			del_timer(&cursor_timer);
+			timer_delete(&cursor_timer);
 			spk_shut_up &= 0xfe;
 			spk_do_flush();
 			read_all_doc(vc);
 			break;
 		case KVAL(K_CTRL):
-			del_timer(&cursor_timer);
+			timer_delete(&cursor_timer);
 			cursor_track = prev_cursor_track;
 			spk_shut_up &= 0xfe;
 			spk_do_flush();
@@ -1399,7 +1399,7 @@ static void start_read_all_timer(struct vc_data *vc, enum read_all_command comma
 
 static void kbd_fakekey2(struct vc_data *vc, enum read_all_command command)
 {
-	del_timer(&cursor_timer);
+	timer_delete(&cursor_timer);
 	speakup_fake_down_arrow();
 	start_read_all_timer(vc, command);
 }
@@ -1415,7 +1415,7 @@ static void read_all_doc(struct vc_data *vc)
 	cursor_track = read_all_mode;
 	spk_reset_index_count(0);
 	if (get_sentence_buf(vc, 0) == -1) {
-		del_timer(&cursor_timer);
+		timer_delete(&cursor_timer);
 		if (!in_keyboard_notifier)
 			speakup_fake_down_arrow();
 		start_read_all_timer(vc, RA_DOWN_ARROW);
@@ -1428,7 +1428,7 @@ static void read_all_doc(struct vc_data *vc)
 
 static void stop_read_all(struct vc_data *vc)
 {
-	del_timer(&cursor_timer);
+	timer_delete(&cursor_timer);
 	cursor_track = prev_cursor_track;
 	spk_shut_up &= 0xfe;
 	spk_do_flush();
@@ -1528,7 +1528,7 @@ static int pre_handle_cursor(struct vc_data *vc, u_char value, char up_flag)
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 			return NOTIFY_STOP;
 		}
-		del_timer(&cursor_timer);
+		timer_delete(&cursor_timer);
 		spk_shut_up &= 0xfe;
 		spk_do_flush();
 		start_read_all_timer(vc, value + 1);
@@ -1692,7 +1692,7 @@ static void cursor_done(struct timer_list *unused)
 	struct vc_data *vc = vc_cons[cursor_con].d;
 	unsigned long flags;
 
-	del_timer(&cursor_timer);
+	timer_delete(&cursor_timer);
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	if (cursor_con != fg_console) {
 		is_cursor = 0;
@@ -2333,7 +2333,7 @@ static void __exit speakup_exit(void)
 	speakup_unregister_devsynth();
 	speakup_cancel_selection();
 	speakup_cancel_paste();
-	del_timer_sync(&cursor_timer);
+	timer_delete_sync(&cursor_timer);
 	kthread_stop(speakup_task);
 	speakup_task = NULL;
 	mutex_lock(&spk_mutex);
@@ -2437,7 +2437,7 @@ error_task:
 
 error_vtnotifier:
 	unregister_keyboard_notifier(&keyboard_notifier_block);
-	del_timer(&cursor_timer);
+	timer_delete(&cursor_timer);
 
 error_kbdnotifier:
 	speakup_unregister_devsynth();
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index 85062e6..d8addbf 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -521,7 +521,7 @@ void synth_release(void)
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	pr_info("releasing synth %s\n", synth->name);
 	synth->alive = 0;
-	del_timer(&thread_timer);
+	timer_delete(&thread_timer);
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	if (synth->attributes.name)
 		sysfs_remove_group(speakup_kobj, &synth->attributes);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 16cd676..b990c1e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -700,7 +700,7 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	ata_eh_acquire(ap);
  repeat:
 	/* kill fast drain timer */
-	del_timer_sync(&ap->fastdrain_timer);
+	timer_delete_sync(&ap->fastdrain_timer);
 
 	/* process port resume request */
 	ata_eh_handle_port_resume(ap);
diff --git a/drivers/atm/idt77105.c b/drivers/atm/idt77105.c
index fcd70e0..e6a3002 100644
--- a/drivers/atm/idt77105.c
+++ b/drivers/atm/idt77105.c
@@ -366,8 +366,8 @@ EXPORT_SYMBOL(idt77105_init);
 static void __exit idt77105_exit(void)
 {
 	/* turn off timers */
-	del_timer_sync(&stats_timer);
-	del_timer_sync(&restart_timer);
+	timer_delete_sync(&stats_timer);
+	timer_delete_sync(&restart_timer);
 }
 
 module_exit(idt77105_exit);
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index d213adc..301e697 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -3283,7 +3283,7 @@ static void __exit ia_module_exit(void)
 {
 	pci_unregister_driver(&ia_driver);
 
-	del_timer_sync(&ia_timer);
+	timer_delete_sync(&ia_timer);
 }
 
 module_init(ia_module_init);
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 32d7aa1..00fe25b 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -1792,7 +1792,7 @@ static inline void lanai_timed_poll_start(struct lanai_dev *lanai)
 
 static inline void lanai_timed_poll_stop(struct lanai_dev *lanai)
 {
-	del_timer_sync(&lanai->timer);
+	timer_delete_sync(&lanai->timer);
 }
 
 /* -------------------- INTERRUPT SERVICE: */
diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 27153d6..45952cf 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -300,7 +300,7 @@ static void __exit nicstar_cleanup(void)
 {
 	XPRINTK("nicstar: nicstar_cleanup() called.\n");
 
-	del_timer_sync(&ns_timer);
+	timer_delete_sync(&ns_timer);
 
 	pci_unregister_driver(&nicstar_driver);
 
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index 32802ea..7d0fa72 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -347,7 +347,7 @@ static int suni_stop(struct atm_dev *dev)
 	for (walk = &sunis; *walk != PRIV(dev);
 	    walk = &PRIV((*walk)->dev)->next);
 	*walk = PRIV((*walk)->dev)->next;
-	if (!sunis) del_timer_sync(&poll_timer);
+	if (!sunis) timer_delete_sync(&poll_timer);
 	spin_unlock_irqrestore(&sunis_lock,flags);
 	kfree(PRIV(dev));
 
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index fcec77f..b6808c4 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -84,7 +84,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 	char *new_msg;
 
 	/* stop the scroll timer */
-	del_timer_sync(&linedisp->timer);
+	timer_delete_sync(&linedisp->timer);
 
 	if (count == -1)
 		count = strlen(msg);
@@ -183,7 +183,7 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 
 	linedisp->scroll_rate = msecs_to_jiffies(ms);
 	if (linedisp->message && linedisp->message_len > linedisp->num_chars) {
-		del_timer_sync(&linedisp->timer);
+		timer_delete_sync(&linedisp->timer);
 		if (linedisp->scroll_rate)
 			linedisp_scroll(&linedisp->timer);
 	}
@@ -376,7 +376,7 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 out_del_dev:
 	device_del(&linedisp->dev);
 out_del_timer:
-	del_timer_sync(&linedisp->timer);
+	timer_delete_sync(&linedisp->timer);
 out_put_device:
 	put_device(&linedisp->dev);
 	return err;
@@ -391,7 +391,7 @@ EXPORT_SYMBOL_NS_GPL(linedisp_register, "LINEDISP");
 void linedisp_unregister(struct linedisp *linedisp)
 {
 	device_del(&linedisp->dev);
-	del_timer_sync(&linedisp->timer);
+	timer_delete_sync(&linedisp->timer);
 	put_device(&linedisp->dev);
 }
 EXPORT_SYMBOL_NS_GPL(linedisp_unregister, "LINEDISP");
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 91ccb97..958c0e3 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1654,7 +1654,7 @@ static void panel_attach(struct parport *port)
 
 err_lcd_unreg:
 	if (scan_timer.function)
-		del_timer_sync(&scan_timer);
+		timer_delete_sync(&scan_timer);
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
@@ -1675,7 +1675,7 @@ static void panel_detach(struct parport *port)
 		return;
 	}
 	if (scan_timer.function)
-		del_timer_sync(&scan_timer);
+		timer_delete_sync(&scan_timer);
 
 	if (keypad.enabled) {
 		misc_deregister(&keypad_dev);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 64840e5..03a39c4 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -41,7 +41,7 @@ struct devcd_entry {
 	 *                                             devcd_data_write()
 	 *                                               mod_delayed_work()
 	 *                                                 try_to_grab_pending()
-	 *                                                   del_timer()
+	 *                                                   timer_delete()
 	 *                                                     debug_assert_init()
 	 *       INIT_DELAYED_WORK()
 	 *       schedule_delayed_work()
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ac2a197..c8b0a9e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -559,7 +559,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 {
 	struct timer_list *timer = &wd->timer;
 
-	del_timer_sync(timer);
+	timer_delete_sync(timer);
 	destroy_timer_on_stack(timer);
 }
 #else
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 752b417..63bf914 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -197,7 +197,7 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 
-	del_timer_sync(&ws->timer);
+	timer_delete_sync(&ws->timer);
 	/*
 	 * Clear timer.function to make wakeup_source_not_registered() treat
 	 * this wakeup source as not registered.
@@ -613,7 +613,7 @@ void __pm_stay_awake(struct wakeup_source *ws)
 	spin_lock_irqsave(&ws->lock, flags);
 
 	wakeup_source_report_event(ws, false);
-	del_timer(&ws->timer);
+	timer_delete(&ws->timer);
 	ws->timer_expires = 0;
 
 	spin_unlock_irqrestore(&ws->lock, flags);
@@ -693,7 +693,7 @@ static void wakeup_source_deactivate(struct wakeup_source *ws)
 		ws->max_time = duration;
 
 	ws->last_time = now;
-	del_timer(&ws->timer);
+	timer_delete(&ws->timer);
 	ws->timer_expires = 0;
 
 	if (ws->autosleep_enabled)
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 9edd446..6357d86 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -457,7 +457,7 @@ static int fd_motor_on(int nr)
 {
 	nr &= 3;
 
-	del_timer(motor_off_timer + nr);
+	timer_delete(motor_off_timer + nr);
 
 	if (!unit[nr].motor) {
 		unit[nr].motor = 1;
@@ -1393,7 +1393,7 @@ static int non_int_flush_track (unsigned long nr)
 
 	nr&=3;
 	writefromint = 0;
-	del_timer(&post_write_timer);
+	timer_delete(&post_write_timer);
 	get_fdc(nr);
 	if (!fd_motor_on(nr)) {
 		writepending = 0;
@@ -1435,7 +1435,7 @@ static int get_track(int drive, int track)
 	}
 
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
+		timer_delete(flush_track_timer + drive);
 		non_int_flush_track (drive);
 	}
 	errcnt = 0;
@@ -1591,7 +1591,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case FDDEFPRM:
 		return -EINVAL;
 	case FDFLUSH: /* unconditionally, even if not needed */
-		del_timer (flush_track_timer + drive);
+		timer_delete(flush_track_timer + drive);
 		non_int_flush_track(drive);
 		break;
 #ifdef RAW_IOCTL
@@ -1714,7 +1714,7 @@ static void floppy_release(struct gendisk *disk)
 
 	mutex_lock(&amiflop_mutex);
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
+		timer_delete(flush_track_timer + drive);
 		non_int_flush_track (drive);
 	}
   
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 4db7f6c..141b2a0 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -274,7 +274,7 @@ freedev(struct aoedev *d)
 	if (!freeing)
 		return;
 
-	del_timer_sync(&d->timer);
+	timer_delete_sync(&d->timer);
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
 		del_gendisk(d->gd);
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 6238c4c..cdf6e40 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -28,7 +28,7 @@ static void discover_timer(struct timer_list *t)
 static void __exit
 aoe_exit(void)
 {
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 
 	aoenet_exit();
 	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a81ade6..7fe1426 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -494,7 +494,7 @@ static inline void start_timeout(void)
 
 static inline void stop_timeout(void)
 {
-	del_timer(&timeout_timer);
+	timer_delete(&timeout_timer);
 }
 
 /* Select the side to use. */
@@ -784,7 +784,7 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	   contents become invalid! */
 	BufferDrive = -1;
 	/* stop deselect timer */
-	del_timer( &motor_off_timer );
+	timer_delete(&motor_off_timer);
 
 	FILL( 60 * (nsect / 9), 0x4e );
 	for( sect = 0; sect < nsect; ++sect ) {
@@ -1138,7 +1138,7 @@ static void fd_rwsec_done( int status )
 	DPRINT(("fd_rwsec_done()\n"));
 
 	if (read_track) {
-		del_timer(&readtrack_timer);
+		timer_delete(&readtrack_timer);
 		if (!MultReadInProgress)
 			return;
 		MultReadInProgress = 0;
@@ -1356,7 +1356,7 @@ static void fd_times_out(struct timer_list *unused)
 	/* If the timeout occurred while the readtrack_check timer was
 	 * active, we need to cancel it, else bad things will happen */
 	if (UseTrackbuffer)
-		del_timer( &readtrack_timer );
+		timer_delete(&readtrack_timer);
 	FDC_WRITE( FDCREG_CMD, FDCCMD_FORCI );
 	udelay( 25 );
 	
@@ -1566,7 +1566,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	/* stop deselect timer */
-	del_timer( &motor_off_timer );
+	timer_delete(&motor_off_timer);
 		
 	ReqCnt = 0;
 	ReqCmd = rq_data_dir(fd_request);
@@ -2055,7 +2055,7 @@ static void atari_floppy_cleanup(void)
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
 
-	del_timer_sync(&fd_timer);
+	timer_delete_sync(&fd_timer);
 	atari_stram_free(DMABuffer);
 }
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5bbd312..ced2cc5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3034,7 +3034,7 @@ void drbd_md_sync(struct drbd_device *device)
 	BUILD_BUG_ON(UI_SIZE != 4);
 	BUILD_BUG_ON(sizeof(struct meta_data_on_disk) != 4096);
 
-	del_timer(&device->md_sync_timer);
+	timer_delete(&device->md_sync_timer);
 	/* timer may be rearmed by drbd_md_mark_dirty() now. */
 	if (!test_and_clear_bit(MD_DIRTY, &device->flags))
 		return;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 720fc30..e09930c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1033,7 +1033,7 @@ drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags, struct
 		/* We do some synchronous IO below, which may take some time.
 		 * Clear the timer, to avoid scary "timer expired!" messages,
 		 * "Superblock" is written out at least twice below, anyways. */
-		del_timer(&device->md_sync_timer);
+		timer_delete(&device->md_sync_timer);
 
 		/* We won't change the "al-extents" setting, we just may need
 		 * to move the on-disk location of the activity log ringbuffer.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f541..e5a2e5f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5187,7 +5187,7 @@ static int drbd_disconnected(struct drbd_peer_device *peer_device)
 	atomic_set(&device->rs_pending_cnt, 0);
 	wake_up(&device->misc_wait);
 
-	del_timer_sync(&device->resync_timer);
+	timer_delete_sync(&device->resync_timer);
 	resync_timer_fn(&device->resync_timer);
 
 	/* wait for all w_e_end_data_req, w_e_end_rsdata_req, w_send_barrier,
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index abf0486..e974320 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -937,7 +937,7 @@ static void floppy_off(unsigned int drive)
 	if (!(fdc_state[fdc].dor & (0x10 << UNIT(drive))))
 		return;
 
-	del_timer(motor_off_timer + drive);
+	timer_delete(motor_off_timer + drive);
 
 	/* make spindle stop in a position which minimizes spinup time
 	 * next time */
@@ -1918,7 +1918,7 @@ static int start_motor(void (*function)(void))
 		mask &= ~(0x10 << UNIT(current_drive));
 
 	/* starts motor and selects floppy */
-	del_timer(motor_off_timer + current_drive);
+	timer_delete(motor_off_timer + current_drive);
 	set_dor(current_fdc, mask, data);
 
 	/* wait_for_completion also schedules reset if needed. */
@@ -4762,7 +4762,7 @@ out_put_disk:
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if (!disks[drive][0])
 			break;
-		del_timer_sync(&motor_off_timer[drive]);
+		timer_delete_sync(&motor_off_timer[drive]);
 		put_disk(disks[drive][0]);
 		blk_mq_free_tag_set(&tag_sets[drive]);
 	}
@@ -4983,7 +4983,7 @@ static void __exit floppy_module_exit(void)
 	destroy_workqueue(floppy_wq);
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
-		del_timer_sync(&motor_off_timer[drive]);
+		timer_delete_sync(&motor_off_timer[drive]);
 
 		if (floppy_available(drive)) {
 			for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 2b33fb5..b5727de 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1070,7 +1070,7 @@ static void vdc_port_remove(struct vio_dev *vdev)
 
 		flush_work(&port->ldc_reset_work);
 		cancel_delayed_work_sync(&port->ldc_reset_timer_work);
-		del_timer_sync(&port->vio.timer);
+		timer_delete_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
 		put_disk(port->disk);
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 3aedcb5..ee6cade 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -362,7 +362,7 @@ static void set_timeout(struct floppy_state *fs, int nticks,
 			void (*proc)(struct timer_list *t))
 {
 	if (fs->timeout_pending)
-		del_timer(&fs->timeout);
+		timer_delete(&fs->timeout);
 	fs->timeout.expires = jiffies + nticks;
 	fs->timeout.function = proc;
 	add_timer(&fs->timeout);
@@ -677,7 +677,7 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 			out_8(&sw->select, RELAX);
 			out_8(&sw->intr_enable, 0);
-			del_timer(&fs->timeout);
+			timer_delete(&fs->timeout);
 			fs->timeout_pending = 0;
 			if (sw->ctrack == 0xff) {
 				swim3_err("%s", "Seen sector but cyl=ff?\n");
@@ -706,7 +706,7 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			out_8(&sw->control_bic, DO_SEEK);
 			out_8(&sw->select, RELAX);
 			out_8(&sw->intr_enable, 0);
-			del_timer(&fs->timeout);
+			timer_delete(&fs->timeout);
 			fs->timeout_pending = 0;
 			if (fs->state == seeking)
 				++fs->retries;
@@ -716,7 +716,7 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 		break;
 	case settling:
 		out_8(&sw->intr_enable, 0);
-		del_timer(&fs->timeout);
+		timer_delete(&fs->timeout);
 		fs->timeout_pending = 0;
 		act(fs);
 		break;
@@ -726,7 +726,7 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 		out_8(&sw->intr_enable, 0);
 		out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 		out_8(&sw->select, RELAX);
-		del_timer(&fs->timeout);
+		timer_delete(&fs->timeout);
 		fs->timeout_pending = 0;
 		dr = fs->dma;
 		cp = fs->dma_cmd;
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 36eabf6..1c7f89e 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -638,7 +638,7 @@ static int bluecard_hci_close(struct hci_dev *hdev)
 	bluecard_hci_flush(hdev);
 
 	/* Stop LED timer */
-	del_timer_sync(&(info->timer));
+	timer_delete_sync(&(info->timer));
 
 	/* Disable power LED */
 	outb(0x00, iobase + 0x30);
@@ -885,7 +885,7 @@ static void bluecard_release(struct pcmcia_device *link)
 
 	bluecard_close(info);
 
-	del_timer_sync(&(info->timer));
+	timer_delete_sync(&(info->timer));
 
 	pcmcia_disable_device(link);
 }
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 7687811..610d0e3 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -382,7 +382,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 	}
 
 	if (skb_queue_empty(&bcsp->unack))
-		del_timer(&bcsp->tbcsp);
+		timer_delete(&bcsp->tbcsp);
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index c043688..edafa22 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -197,7 +197,7 @@ static void h5_peer_reset(struct hci_uart *hu)
 
 	h5->state = H5_UNINITIALIZED;
 
-	del_timer(&h5->timer);
+	timer_delete(&h5->timer);
 
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
@@ -254,7 +254,7 @@ static int h5_close(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
 
-	del_timer_sync(&h5->timer);
+	timer_delete_sync(&h5->timer);
 
 	skb_queue_purge(&h5->unack);
 	skb_queue_purge(&h5->rel);
@@ -318,7 +318,7 @@ static void h5_pkt_cull(struct h5 *h5)
 	}
 
 	if (skb_queue_empty(&h5->unack))
-		del_timer(&h5->timer);
+		timer_delete(&h5->timer);
 
 unlock:
 	spin_unlock_irqrestore(&h5->unack.lock, flags);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f255850..e00590b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -867,7 +867,7 @@ static void device_woke_up(struct hci_uart *hu)
 			skb_queue_tail(&qca->txq, skb);
 
 		/* Switch timers and change state to HCI_IBS_TX_AWAKE */
-		del_timer(&qca->wake_retrans_timer);
+		timer_delete(&qca->wake_retrans_timer);
 		idle_delay = msecs_to_jiffies(qca->tx_idle_delay);
 		mod_timer(&qca->tx_idle_timer, jiffies + idle_delay);
 		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
@@ -2239,8 +2239,8 @@ static int qca_power_off(struct hci_dev *hdev)
 	hu->hdev->hw_error = NULL;
 	hu->hdev->reset = NULL;
 
-	del_timer_sync(&qca->wake_retrans_timer);
-	del_timer_sync(&qca->tx_idle_timer);
+	timer_delete_sync(&qca->wake_retrans_timer);
+	timer_delete_sync(&qca->tx_idle_timer);
 
 	/* Stop sending shutdown command if soc crashes. */
 	if (soc_type != QCA_ROME
@@ -2629,10 +2629,10 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_WAKING:
-		del_timer(&qca->wake_retrans_timer);
+		timer_delete(&qca->wake_retrans_timer);
 		fallthrough;
 	case HCI_IBS_TX_AWAKE:
-		del_timer(&qca->tx_idle_timer);
+		timer_delete(&qca->tx_idle_timer);
 
 		serdev_device_write_flush(hu->serdev);
 		cmd = HCI_IBS_SLEEP_IND;
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 474f135..03aa887 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1096,7 +1096,7 @@ static void mhi_pci_recovery_work(struct work_struct *work)
 
 	dev_warn(&pdev->dev, "device recovery started\n");
 
-	del_timer(&mhi_pdev->health_check_timer);
+	timer_delete(&mhi_pdev->health_check_timer);
 	pm_runtime_forbid(&pdev->dev);
 
 	/* Clean up MHI state */
@@ -1293,7 +1293,7 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
 	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
 
-	del_timer_sync(&mhi_pdev->health_check_timer);
+	timer_delete_sync(&mhi_pdev->health_check_timer);
 	cancel_work_sync(&mhi_pdev->recovery_work);
 
 	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
@@ -1321,7 +1321,7 @@ static void mhi_pci_reset_prepare(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev, "reset\n");
 
-	del_timer(&mhi_pdev->health_check_timer);
+	timer_delete(&mhi_pdev->health_check_timer);
 
 	/* Clean up MHI state */
 	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
@@ -1431,7 +1431,7 @@ static int  __maybe_unused mhi_pci_runtime_suspend(struct device *dev)
 	if (test_and_set_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
 		return 0;
 
-	del_timer(&mhi_pdev->health_check_timer);
+	timer_delete(&mhi_pdev->health_check_timer);
 	cancel_work_sync(&mhi_pdev->recovery_work);
 
 	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index 27f5f9d..1661807 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -243,11 +243,11 @@ static __poll_t dtlk_poll(struct file *file, poll_table * wait)
 	poll_wait(file, &dtlk_process_list, wait);
 
 	if (dtlk_has_indexing && dtlk_readable()) {
-	        del_timer(&dtlk_timer);
+	        timer_delete(&dtlk_timer);
 		mask = EPOLLIN | EPOLLRDNORM;
 	}
 	if (dtlk_writeable()) {
-	        del_timer(&dtlk_timer);
+	        timer_delete(&dtlk_timer);
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 	/* there are no exception conditions */
@@ -322,7 +322,7 @@ static int dtlk_release(struct inode *inode, struct file *file)
 	}
 	TRACE_RET;
 	
-	del_timer_sync(&dtlk_timer);
+	timer_delete_sync(&dtlk_timer);
 
 	return 0;
 }
diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 4181bcc..497fc16 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -167,7 +167,7 @@ static int __init hangcheck_init(void)
 
 static void __exit hangcheck_exit(void)
 {
-	del_timer_sync(&hangcheck_ticktock);
+	timer_delete_sync(&hangcheck_ticktock);
         printk("Hangcheck: Stopped hangcheck timer.\n");
 }
 
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 39acaa5..a1a7510 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -93,7 +93,7 @@ static void xgene_rng_expired_timer(struct timer_list *t)
 	/* Clear failure counter as timer expired */
 	disable_irq(ctx->irq);
 	ctx->failure_cnt = 0;
-	del_timer(&ctx->failure_timer);
+	timer_delete(&ctx->failure_timer);
 	enable_irq(ctx->irq);
 }
 
diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 009e320..77146b5 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -465,7 +465,7 @@ static void bt_bmc_remove(struct platform_device *pdev)
 
 	misc_deregister(&bt_bmc->miscdev);
 	if (bt_bmc->irq < 0)
-		del_timer_sync(&bt_bmc->poll_timer);
+		timer_delete_sync(&bt_bmc->poll_timer);
 }
 
 static const struct of_device_id bt_bmc_match[] = {
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 1e53137..3ba9d7e 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5538,7 +5538,7 @@ static void __exit cleanup_ipmi(void)
 		 * here.
 		 */
 		atomic_set(&stop_operation, 1);
-		del_timer_sync(&ipmi_timer);
+		timer_delete_sync(&ipmi_timer);
 
 		initialized = false;
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index eea23a3..12b0b77 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -859,7 +859,7 @@ restart:
 
 	if (si_sm_result == SI_SM_IDLE && smi_info->timer_running) {
 		/* Ok it if fails, the timer will just go off. */
-		if (del_timer(&smi_info->si_timer))
+		if (timer_delete(&smi_info->si_timer))
 			smi_info->timer_running = false;
 	}
 
@@ -1839,7 +1839,7 @@ static inline void stop_timer_and_thread(struct smi_info *smi_info)
 	}
 
 	smi_info->timer_can_start = false;
-	del_timer_sync(&smi_info->si_timer);
+	timer_delete_sync(&smi_info->si_timer);
 }
 
 static struct smi_info *find_dup_si(struct smi_info *info)
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 506d998..0b45b07 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -599,7 +599,7 @@ static void ssif_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
 	if (ssif_info->waiting_alert) {
 		ssif_info->waiting_alert = false;
-		del_timer(&ssif_info->retry_timer);
+		timer_delete(&ssif_info->retry_timer);
 		do_get = true;
 	} else if (ssif_info->curr_msg) {
 		ssif_info->got_alert = true;
@@ -1268,8 +1268,8 @@ static void shutdown_ssif(void *send_info)
 		schedule_timeout(1);
 
 	ssif_info->stopping = true;
-	del_timer_sync(&ssif_info->watch_timer);
-	del_timer_sync(&ssif_info->retry_timer);
+	timer_delete_sync(&ssif_info->watch_timer);
+	timer_delete_sync(&ssif_info->retry_timer);
 	if (ssif_info->thread) {
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index c03bc1e..a13a347 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -428,7 +428,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, 
 			if (rc == -ETIMEDOUT)
 				mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
 		} else {
-			del_timer(&priv->obe.timer);
+			timer_delete(&priv->obe.timer);
 		}
 	}
 
@@ -655,7 +655,7 @@ static void aspeed_kcs_remove(struct platform_device *pdev)
 	spin_lock_irq(&priv->obe.lock);
 	priv->obe.remove = true;
 	spin_unlock_irq(&priv->obe.lock);
-	del_timer_sync(&priv->obe.timer);
+	timer_delete_sync(&priv->obe.timer);
 }
 
 static const struct of_device_id ast_kcs_bmc_match[] = {
diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index 310f17d..e4bd745 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -209,7 +209,7 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t 
 	if (ret)
 		goto exit;
 
-	del_timer(&ssif_bmc->response_timer);
+	timer_delete(&ssif_bmc->response_timer);
 	ssif_bmc->response_timer_inited = false;
 
 	memcpy(&ssif_bmc->response, &msg, count);
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 92cbd24..38f2fab 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1352,7 +1352,7 @@ static void __cold try_to_generate_entropy(void)
 	}
 	mix_pool_bytes(&stack->entropy, sizeof(stack->entropy));
 
-	del_timer_sync(&stack->timer);
+	timer_delete_sync(&stack->timer);
 	destroy_timer_on_stack(&stack->timer);
 }
 
diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 6c1d94e..b381ea7 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -838,7 +838,7 @@ static void __exit tlclk_cleanup(void)
 	unregister_chrdev(tlclk_major, "telco_clock");
 
 	release_region(TLCLK_BASE, 8);
-	del_timer_sync(&switchover_timer);
+	timer_delete_sync(&switchover_timer);
 	kfree(alarm_events);
 
 }
@@ -856,7 +856,7 @@ static void switchover_timeout(struct timer_list *unused)
 	}
 
 	/* Alarm processing is done, wake up read task */
-	del_timer(&switchover_timer);
+	timer_delete(&switchover_timer);
 	got_event = 1;
 	wake_up(&wq);
 }
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 48ff874..11deaf5 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -160,7 +160,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 out:
 	if (!priv->response_length) {
 		*off = 0;
-		del_timer_sync(&priv->user_read_timer);
+		timer_delete_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -267,7 +267,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
 	flush_work(&priv->async_work);
-	del_timer_sync(&priv->user_read_timer);
+	timer_delete_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
 	priv->response_length = 0;
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 05ae912..da17d89 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -418,9 +418,9 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
-		del_timer(&devpriv->ai_timer);
+		timer_delete(&devpriv->ai_timer);
 	} else {
-		del_timer_sync(&devpriv->ai_timer);
+		timer_delete_sync(&devpriv->ai_timer);
 	}
 	return 0;
 }
@@ -628,9 +628,9 @@ static int waveform_ao_cancel(struct comedi_device *dev,
 	spin_unlock_bh(&dev->spinlock);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
-		del_timer(&devpriv->ao_timer);
+		timer_delete(&devpriv->ao_timer);
 	} else {
-		del_timer_sync(&devpriv->ao_timer);
+		timer_delete_sync(&devpriv->ao_timer);
 	}
 	return 0;
 }
@@ -791,8 +791,8 @@ static void waveform_detach(struct comedi_device *dev)
 	struct waveform_private *devpriv = dev->private;
 
 	if (devpriv) {
-		del_timer_sync(&devpriv->ai_timer);
-		del_timer_sync(&devpriv->ao_timer);
+		timer_delete_sync(&devpriv->ai_timer);
+		timer_delete_sync(&devpriv->ao_timer);
 	}
 }
 
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 4ed56a0..f5ca6c0 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -775,7 +775,7 @@ static int das16_cancel(struct comedi_device *dev, struct comedi_subdevice *s)
 	/*  disable SW timer */
 	if (devpriv->timer_running) {
 		devpriv->timer_running = 0;
-		del_timer(&devpriv->timer);
+		timer_delete(&devpriv->timer);
 	}
 
 	if (devpriv->can_burst)
@@ -940,7 +940,7 @@ static void das16_free_dma(struct comedi_device *dev)
 	struct das16_private_struct *devpriv = dev->private;
 
 	if (devpriv) {
-		del_timer_sync(&devpriv->timer);
+		timer_delete_sync(&devpriv->timer);
 		comedi_isadma_free(devpriv->dma);
 	}
 }
diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 951c23f..cdc842b 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -758,7 +758,7 @@ static void jr3_pci_detach(struct comedi_device *dev)
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
 	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+		timer_delete_sync(&devpriv->timer);
 
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 6094c53..afe5abf 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -802,7 +802,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	if (gpstate_idx != new_index)
 		queue_gpstate_timer(gpstates);
 	else
-		del_timer_sync(&gpstates->timer);
+		timer_delete_sync(&gpstates->timer);
 
 gpstates_done:
 	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
@@ -880,7 +880,7 @@ static void powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
 	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
 	if (gpstates)
-		del_timer_sync(&gpstates->timer);
+		timer_delete_sync(&gpstates->timer);
 
 	kfree(policy->driver_data);
 }
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 500b08e..f8d50bd 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2067,7 +2067,7 @@ static void artpec6_crypto_process_queue(struct artpec6_crypto *ac,
 	if (ac->pending_count)
 		mod_timer(&ac->timer, jiffies + msecs_to_jiffies(100));
 	else
-		del_timer(&ac->timer);
+		timer_delete(&ac->timer);
 }
 
 static void artpec6_crypto_timeout(struct timer_list *t)
@@ -2963,7 +2963,7 @@ static void artpec6_crypto_remove(struct platform_device *pdev)
 	tasklet_disable(&ac->task);
 	devm_free_irq(&pdev->dev, irq, ac);
 	tasklet_kill(&ac->task);
-	del_timer_sync(&ac->timer);
+	timer_delete_sync(&ac->timer);
 
 	artpec6_crypto_disable_hw(ac);
 
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index cf2ce37..9f80a45 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -412,7 +412,7 @@ static int test_wait_timeout(void *arg)
 
 	err = 0;
 err_free:
-	del_timer_sync(&wt.timer);
+	timer_delete_sync(&wt.timer);
 	destroy_timer_on_stack(&wt.timer);
 	dma_fence_signal(wt.f);
 	dma_fence_put(wt.f);
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index de8d707..b96cc0a 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -324,7 +324,7 @@ static void imxdma_disable_hw(struct imxdma_channel *imxdmac)
 	dev_dbg(imxdma->dev, "%s channel %d\n", __func__, channel);
 
 	if (imxdma_hw_chain(imxdmac))
-		del_timer(&imxdmac->watchdog);
+		timer_delete(&imxdmac->watchdog);
 
 	local_irq_save(flags);
 	imx_dmav1_writel(imxdma, imx_dmav1_readl(imxdma, DMA_DIMR) |
@@ -454,7 +454,7 @@ static void dma_irq_handle_channel(struct imxdma_channel *imxdmac)
 		}
 
 		if (imxdma_hw_chain(imxdmac)) {
-			del_timer(&imxdmac->watchdog);
+			timer_delete(&imxdmac->watchdog);
 			return;
 		}
 	}
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 79d8957..06a813c 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -159,7 +159,7 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 	}
 
 	/* flush inflight timers */
-	del_timer_sync(&ioat_chan->timer);
+	timer_delete_sync(&ioat_chan->timer);
 
 	/* flush inflight tasklet runs */
 	tasklet_kill(&ioat_chan->cleanup_task);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index cc9ddd6..02f68b3 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1224,12 +1224,12 @@ static void ioat_shutdown(struct pci_dev *pdev)
 		set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
 		spin_unlock_bh(&ioat_chan->prep_lock);
 		/*
-		 * Synchronization rule for del_timer_sync():
+		 * Synchronization rule for timer_delete_sync():
 		 *  - The caller must not hold locks which would prevent
 		 *    completion of the timer's handler.
 		 * So prep_lock cannot be held before calling it.
 		 */
-		del_timer_sync(&ioat_chan->timer);
+		timer_delete_sync(&ioat_chan->timer);
 
 		/* this should quiesce then reset */
 		ioat_reset_hw(ioat_chan);
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index e141d24..b0f9ef6 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -39,7 +39,7 @@
 static int try_cancel_split_timeout(struct fw_transaction *t)
 {
 	if (t->is_split_transaction)
-		return del_timer(&t->split_timeout_timer);
+		return timer_delete(&t->split_timeout_timer);
 	else
 		return 1;
 }
diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb46..b662b7e 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -342,7 +342,7 @@ static int suspend_test_thread(void *arg)
 	 * Disable the timer to make sure that the timer will not trigger
 	 * later.
 	 */
-	del_timer(&wakeup_timer);
+	timer_delete(&wakeup_timer);
 	destroy_timer_on_stack(&wakeup_timer);
 
 	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6a..5f5c00a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -280,7 +280,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	} while (atomic_cmpxchg(&drv->last_seq, last_seq, seq) != last_seq);
 
-	if (del_timer(&ring->fence_drv.fallback_timer) &&
+	if (timer_delete(&ring->fence_drv.fallback_timer) &&
 	    seq != ring->fence_drv.sync_seq)
 		amdgpu_fence_schedule_fallback(ring);
 
@@ -618,7 +618,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
-		del_timer_sync(&ring->fence_drv.fallback_timer);
+		timer_delete_sync(&ring->fence_drv.fallback_timer);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 85f7740..fb212f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1239,7 +1239,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
-	del_timer_sync(&ring->fence_drv.fallback_timer);
+	timer_delete_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 1c66da1..03ed146 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -124,7 +124,7 @@ static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
 		}
 	}
 
-	del_timer(&mux->resubmit_timer);
+	timer_delete(&mux->resubmit_timer);
 	mux->s_resubmit = false;
 }
 
diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index ebc758c..2065825 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1763,7 +1763,7 @@ static void tda998x_destroy(struct device *dev)
 	if (priv->hdmi->irq)
 		free_irq(priv->hdmi->irq, priv);
 
-	del_timer_sync(&priv->edid_delay_timer);
+	timer_delete_sync(&priv->edid_delay_timer);
 	cancel_work_sync(&priv->detect_work);
 
 	i2c_unregister_device(priv->cec);
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 94e45ed..78958dd 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -508,7 +508,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 		    drm_core_check_feature(dev, DRIVER_MODESET));
 
 	drm_vblank_destroy_worker(vblank);
-	del_timer_sync(&vblank->disable_timer);
+	timer_delete_sync(&vblank->disable_timer);
 }
 
 /**
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index fd388b1..08cf79a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -427,7 +427,7 @@ static void vidi_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
 
-	del_timer_sync(&ctx->timer);
+	timer_delete_sync(&ctx->timer);
 }
 
 static const struct component_ops vidi_component_ops = {
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index e163649..77cfcf3 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -254,7 +254,7 @@ static int gud_usb_bulk(struct gud_device *gdrm, size_t len)
 
 	usb_sg_wait(&ctx.sgr);
 
-	if (!del_timer_sync(&ctx.timer))
+	if (!timer_delete_sync(&ctx.timer))
 		ret = -ETIMEDOUT;
 	else if (ctx.sgr.status < 0)
 		ret = ctx.sgr.status;
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 4a80ffa..03baa7f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2502,7 +2502,7 @@ static void execlists_irq_handler(struct intel_engine_cs *engine, u16 iir)
 			   ENGINE_READ_FW(engine, RING_EXECLIST_STATUS_HI));
 		ENGINE_TRACE(engine, "semaphore yield: %08x\n",
 			     engine->execlists.yield);
-		if (del_timer(&engine->execlists.timer))
+		if (timer_delete(&engine->execlists.timer))
 			tasklet = true;
 	}
 
@@ -3370,8 +3370,8 @@ static void execlists_set_default_submission(struct intel_engine_cs *engine)
 static void execlists_shutdown(struct intel_engine_cs *engine)
 {
 	/* Synchronise with residual timers and any softirq they raise */
-	del_timer_sync(&engine->execlists.timer);
-	del_timer_sync(&engine->execlists.preempt);
+	timer_delete_sync(&engine->execlists.timer);
+	timer_delete_sync(&engine->execlists.preempt);
 	tasklet_kill(&engine->sched_engine->tasklet);
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_rps.c b/drivers/gpu/drm/i915/gt/intel_rps.c
index 2cfaedb..64e9317 100644
--- a/drivers/gpu/drm/i915/gt/intel_rps.c
+++ b/drivers/gpu/drm/i915/gt/intel_rps.c
@@ -161,7 +161,7 @@ static void rps_start_timer(struct intel_rps *rps)
 
 static void rps_stop_timer(struct intel_rps *rps)
 {
-	del_timer_sync(&rps->timer);
+	timer_delete_sync(&rps->timer);
 	rps->pm_timestamp = ktime_sub(ktime_get(), rps->pm_timestamp);
 	cancel_work_sync(&rps->work);
 }
diff --git a/drivers/gpu/drm/i915/gt/mock_engine.c b/drivers/gpu/drm/i915/gt/mock_engine.c
index c0637bf..64315b7 100644
--- a/drivers/gpu/drm/i915/gt/mock_engine.c
+++ b/drivers/gpu/drm/i915/gt/mock_engine.c
@@ -297,7 +297,7 @@ static void mock_reset_cancel(struct intel_engine_cs *engine)
 	struct i915_request *rq;
 	unsigned long flags;
 
-	del_timer_sync(&mock->hw_delay);
+	timer_delete_sync(&mock->hw_delay);
 
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
 
@@ -432,7 +432,7 @@ void mock_engine_flush(struct intel_engine_cs *engine)
 		container_of(engine, typeof(*mock), base);
 	struct i915_request *request, *rn;
 
-	del_timer_sync(&mock->hw_delay);
+	timer_delete_sync(&mock->hw_delay);
 
 	spin_lock_irq(&mock->hw_lock);
 	list_for_each_entry_safe(request, rn, &mock->hw_queue, mock.link)
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index d7717de..0454eb1 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1198,7 +1198,7 @@ static int live_timeslice_rewind(void *arg)
 		ENGINE_TRACE(engine, "forcing tasklet for rewind\n");
 		while (i915_request_is_active(rq[A2])) { /* semaphore yield! */
 			/* Wait for the timeslice to kick in */
-			del_timer(&engine->execlists.timer);
+			timer_delete(&engine->execlists.timer);
 			tasklet_hi_schedule(&engine->sched_engine->tasklet);
 			intel_engine_flush_submission(engine);
 		}
@@ -2357,7 +2357,7 @@ static int __cancel_fail(struct live_preempt_cancel *arg)
 	/* force preempt reset [failure] */
 	while (!engine->execlists.pending[0])
 		intel_engine_flush_submission(engine);
-	del_timer_sync(&engine->execlists.preempt);
+	timer_delete_sync(&engine->execlists.preempt);
 	intel_engine_flush_submission(engine);
 
 	cancel_reset_timeout(engine);
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 1bf7b88..401bee0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -660,7 +660,7 @@ static int live_emit_pte_full_ring(void *arg)
 
 out_rq:
 	i915_request_add(rq); /* GEM_BUG_ON(rq->reserved_space > ring->space)? */
-	del_timer_sync(&st.timer);
+	timer_delete_sync(&st.timer);
 	destroy_timer_on_stack(&st.timer);
 out_unpin:
 	intel_context_unpin(ce);
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_utils.c
index 2576f8f..b60c28f 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -52,7 +52,7 @@ void cancel_timer(struct timer_list *t)
 	if (!timer_active(t))
 		return;
 
-	del_timer(t);
+	timer_delete(t);
 	WRITE_ONCE(t->expires, 0);
 }
 
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 87f2460..07e81be 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -163,7 +163,7 @@ void intel_wakeref_auto(struct intel_wakeref_auto *wf, unsigned long timeout)
 	unsigned long flags;
 
 	if (!timeout) {
-		if (del_timer_sync(&wf->timer))
+		if (timer_delete_sync(&wf->timer))
 			wakeref_auto_timeout(&wf->timer);
 		return;
 	}
diff --git a/drivers/gpu/drm/i915/selftests/lib_sw_fence.c b/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
index bf2752c..d5ecc68 100644
--- a/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
@@ -74,7 +74,7 @@ void timed_fence_init(struct timed_fence *tf, unsigned long expires)
 
 void timed_fence_fini(struct timed_fence *tf)
 {
-	if (del_timer_sync(&tf->timer))
+	if (timer_delete_sync(&tf->timer))
 		i915_sw_fence_commit(&tf->fence);
 
 	destroy_timer_on_stack(&tf->timer);
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index ccdc57c..fed3307 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2847,7 +2847,7 @@ static void mtk_dp_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	if (mtk_dp->data->bridge_type != DRM_MODE_CONNECTOR_eDP)
-		del_timer_sync(&mtk_dp->debounce_timer);
+		timer_delete_sync(&mtk_dp->debounce_timer);
 	platform_device_unregister(mtk_dp->phy_dev);
 	if (mtk_dp->audio_pdev)
 		platform_device_unregister(mtk_dp->audio_pdev);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 71dca78..650e5ba 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1253,7 +1253,7 @@ static void a5xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ));
 
 	/* Turn off the hangcheck timer to keep it from bothering us */
-	del_timer(&gpu->hangcheck_timer);
+	timer_delete(&gpu->hangcheck_timer);
 
 	kthread_queue_work(gpu->worker, &gpu->recover_work);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 0469fea..36f72c4 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -182,7 +182,7 @@ void a5xx_preempt_irq(struct msm_gpu *gpu)
 		return;
 
 	/* Delete the preemption watchdog timer */
-	del_timer(&a5xx_gpu->preempt_timer);
+	timer_delete(&a5xx_gpu->preempt_timer);
 
 	/*
 	 * The hardware should be setting CP_CONTEXT_SWITCH_CNTL to zero before
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 38c9491..c871193 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -28,7 +28,7 @@ static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
 	gmu->hung = true;
 
 	/* Turn off the hangcheck timer while we are resetting */
-	del_timer(&gpu->hangcheck_timer);
+	timer_delete(&gpu->hangcheck_timer);
 
 	/* Queue the GPU handler because we need to treat this as a recovery */
 	kthread_queue_work(gpu->worker, &gpu->recover_work);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1820c16..06465bc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1706,7 +1706,7 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE));
 
 	/* Turn off the hangcheck timer to keep it from bothering us */
-	del_timer(&gpu->hangcheck_timer);
+	timer_delete(&gpu->hangcheck_timer);
 
 	kthread_queue_work(gpu->worker, &gpu->recover_work);
 }
@@ -1726,7 +1726,7 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
 	 */
 	if (status & (A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
 		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC)) {
-		del_timer(&gpu->hangcheck_timer);
+		timer_delete(&gpu->hangcheck_timer);
 
 		kthread_queue_work(gpu->worker, &gpu->recover_work);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 2fd4e39..9b5e27d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -146,7 +146,7 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
 		return;
 
 	/* Delete the preemption watchdog timer */
-	del_timer(&a6xx_gpu->preempt_timer);
+	timer_delete(&a6xx_gpu->preempt_timer);
 
 	/*
 	 * The hardware should be setting the stop bit of CP_CONTEXT_SWITCH_CNTL
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 7156cda..26db1f4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -292,7 +292,7 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 
 	if (do_devcoredump) {
 		/* Turn off the hangcheck timer to keep it from bothering us */
-		del_timer(&gpu->hangcheck_timer);
+		timer_delete(&gpu->hangcheck_timer);
 
 		gpu->fault_info.ttbr0 = info->ttbr0;
 		gpu->fault_info.iova  = iova;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 284e69b..8610bbf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1410,7 +1410,7 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 	/* after phys waits for frame-done, should be no more frames pending */
 	if (atomic_xchg(&dpu_enc->frame_done_timeout_ms, 0)) {
 		DPU_ERROR("enc%d timeout pending\n", drm_enc->base.id);
-		del_timer_sync(&dpu_enc->frame_done_timer);
+		timer_delete_sync(&dpu_enc->frame_done_timer);
 	}
 
 	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_STOP);
@@ -1582,7 +1582,7 @@ void dpu_encoder_frame_done_callback(
 
 		if (!dpu_enc->frame_busy_mask[0]) {
 			atomic_set(&dpu_enc->frame_done_timeout_ms, 0);
-			del_timer(&dpu_enc->frame_done_timer);
+			timer_delete(&dpu_enc->frame_done_timer);
 
 			dpu_encoder_resource_control(drm_enc,
 					DPU_ENC_RC_EVENT_FRAME_DONE);
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 59d20eb..9b9cc59 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -452,7 +452,7 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 
 #ifdef DSI_CATCH_MISSING_TE
 	if (irqstatus & DSI_IRQ_TE_TRIGGER)
-		del_timer(&dsi->te_timer);
+		timer_delete(&dsi->te_timer);
 #endif
 
 	/* make a copy and unlock, so that isrs can unregister
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index fb450b6..7125773 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -1043,7 +1043,7 @@ static void vc4_bo_cache_destroy(struct drm_device *dev, void *unused)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int i;
 
-	del_timer(&vc4->bo_cache.time_timer);
+	timer_delete(&vc4->bo_cache.time_timer);
 	cancel_work_sync(&vc4->bo_cache.time_work);
 
 	vc4_bo_cache_purge(dev);
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index e157541..37bb1fb 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -49,7 +49,7 @@ static void vgem_fence_release(struct dma_fence *base)
 {
 	struct vgem_fence *fence = container_of(base, typeof(*fence), base);
 
-	del_timer_sync(&fence->timer);
+	timer_delete_sync(&fence->timer);
 	dma_fence_free(&fence->base);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index 9fbed1a..788f56b 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -297,7 +297,7 @@ err:
 
 void xe_execlist_port_destroy(struct xe_execlist_port *port)
 {
-	del_timer(&port->irq_fail);
+	timer_delete(&port->irq_fail);
 
 	/* Prevent an interrupt while we're destroying */
 	spin_lock_irq(&gt_to_xe(port->hwe->gt)->irq.lock);
diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 8459e9b..f6beeeb 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -279,7 +279,7 @@ static void gb_operation_work(struct work_struct *work)
 	if (gb_operation_is_incoming(operation)) {
 		gb_operation_request_handle(operation);
 	} else {
-		ret = del_timer_sync(&operation->timer);
+		ret = timer_delete_sync(&operation->timer);
 		if (!ret) {
 			/* Cancel request message if scheduled by timeout. */
 			if (gb_operation_result(operation) == -ETIMEDOUT)
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d900dd0..ed34f5c 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -950,7 +950,7 @@ static int apple_probe(struct hid_device *hdev,
 	return 0;
 
 out_err:
-	del_timer_sync(&asc->battery_timer);
+	timer_delete_sync(&asc->battery_timer);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -959,7 +959,7 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	del_timer_sync(&asc->battery_timer);
+	timer_delete_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index c45e5aa..bb7db9a 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -319,7 +319,7 @@ static void appleir_remove(struct hid_device *hid)
 {
 	struct appleir *appleir = hid_get_drvdata(hid);
 	hid_hw_stop(hid);
-	del_timer_sync(&appleir->key_up_timer);
+	timer_delete_sync(&appleir->key_up_timer);
 }
 
 static const struct hid_device_id appleir_devices[] = {
diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index d4b95aa..029ccba 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -448,7 +448,7 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
 	input_unregister_handler(&kbd->inp_handler);
-	del_timer_sync(&kbd->inactivity_timer);
+	timer_delete_sync(&kbd->inactivity_timer);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index a76f171..adfa329 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -915,7 +915,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	del_timer_sync(&msc->battery_timer);
+	timer_delete_sync(&msc->battery_timer);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -926,7 +926,7 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		del_timer_sync(&msc->battery_timer);
+		timer_delete_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e50887a..7ac8e16 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1299,7 +1299,7 @@ static void mt_touch_report(struct hid_device *hid,
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
-			del_timer(&td->release_timer);
+			timer_delete(&td->release_timer);
 	}
 
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
@@ -1881,7 +1881,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
-	del_timer_sync(&td->release_timer);
+	timer_delete_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index ff9078a..b0c40a2 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -1102,7 +1102,7 @@ static void shield_remove(struct hid_device *hdev)
 
 	hid_hw_close(hdev);
 	thunderstrike_destroy(ts);
-	del_timer_sync(&ts->psy_stats_timer);
+	timer_delete_sync(&ts->psy_stats_timer);
 	cancel_work_sync(&ts->hostcmd_req_work);
 	hid_hw_stop(hdev);
 }
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 3d08c19..c6b922c 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -254,7 +254,7 @@ static void stop_sustain_timers(struct pcmidi_snd *pm)
 	for (i = 0; i < PCMIDI_SUSTAINED_MAX; i++) {
 		pms = &pm->sustained_notes[i];
 		pms->in_use = 1;
-		del_timer_sync(&pms->timer);
+		timer_delete_sync(&pms->timer);
 	}
 }
 
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5258b45..a2be652 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2164,7 +2164,7 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		del_timer_sync(&sc->ghl_poke_timer);
+		timer_delete_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index d800893..a367df6 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -474,7 +474,7 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	del_timer_sync(&drvdata->inrange_timer);
+	timer_delete_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 26167cf..8080083 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1171,7 +1171,7 @@ static void wiimote_init_hotplug(struct wiimote_data *wdata)
 		wiimote_cmd_release(wdata);
 
 		/* delete MP hotplug timer */
-		del_timer_sync(&wdata->timer);
+		timer_delete_sync(&wdata->timer);
 	} else {
 		/* reschedule MP hotplug timer */
 		if (!(flags & WIIPROTO_FLAG_BUILTIN_MP) &&
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 44c2351..7d9297f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1462,13 +1462,13 @@ static void usbhid_disconnect(struct usb_interface *intf)
 
 static void hid_cancel_delayed_stuff(struct usbhid_device *usbhid)
 {
-	del_timer_sync(&usbhid->io_retry);
+	timer_delete_sync(&usbhid->io_retry);
 	cancel_work_sync(&usbhid->reset_work);
 }
 
 static void hid_cease_io(struct usbhid_device *usbhid)
 {
-	del_timer_sync(&usbhid->io_retry);
+	timer_delete_sync(&usbhid->io_retry);
 	usb_kill_urb(usbhid->urbin);
 	usb_kill_urb(usbhid->urbctrl);
 	usb_kill_urb(usbhid->urbout);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 97393a3..1556d42 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2896,7 +2896,7 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
 	cancel_work_sync(&wacom->mode_change_work);
-	del_timer_sync(&wacom->idleprox_timer);
+	timer_delete_sync(&wacom->idleprox_timer);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 6105ea9..cbc5e72 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -281,9 +281,9 @@ static void ssip_set_rxstate(struct ssi_protocol *ssi, unsigned int state)
 	ssi->recv_state = state;
 	switch (state) {
 	case RECV_IDLE:
-		del_timer(&ssi->rx_wd);
+		timer_delete(&ssi->rx_wd);
 		if (ssi->send_state == SEND_IDLE)
-			del_timer(&ssi->keep_alive);
+			timer_delete(&ssi->keep_alive);
 		break;
 	case RECV_READY:
 		/* CMT speech workaround */
@@ -306,9 +306,9 @@ static void ssip_set_txstate(struct ssi_protocol *ssi, unsigned int state)
 	switch (state) {
 	case SEND_IDLE:
 	case SEND_READY:
-		del_timer(&ssi->tx_wd);
+		timer_delete(&ssi->tx_wd);
 		if (ssi->recv_state == RECV_IDLE)
-			del_timer(&ssi->keep_alive);
+			timer_delete(&ssi->keep_alive);
 		break;
 	case WAIT4READY:
 	case SENDING:
@@ -398,9 +398,9 @@ static void ssip_reset(struct hsi_client *cl)
 	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 		ssi_waketest(cl, 0); /* FIXME: To be removed */
 	spin_lock_bh(&ssi->lock);
-	del_timer(&ssi->rx_wd);
-	del_timer(&ssi->tx_wd);
-	del_timer(&ssi->keep_alive);
+	timer_delete(&ssi->rx_wd);
+	timer_delete(&ssi->tx_wd);
+	timer_delete(&ssi->keep_alive);
 	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
@@ -648,7 +648,7 @@ static void ssip_rx_data_complete(struct hsi_msg *msg)
 		ssip_error(cl);
 		return;
 	}
-	del_timer(&ssi->rx_wd); /* FIXME: Revisit */
+	timer_delete(&ssi->rx_wd); /* FIXME: Revisit */
 	skb = msg->context;
 	ssip_pn_rx(skb);
 	hsi_free_msg(msg);
@@ -731,7 +731,7 @@ static void ssip_rx_waketest(struct hsi_client *cl, u32 cmd)
 
 	spin_lock_bh(&ssi->lock);
 	ssi->main_state = ACTIVE;
-	del_timer(&ssi->tx_wd); /* Stop boot handshake timer */
+	timer_delete(&ssi->tx_wd); /* Stop boot handshake timer */
 	spin_unlock_bh(&ssi->lock);
 
 	dev_notice(&cl->device, "WAKELINES TEST %s\n",
diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index f890b79..94e931f 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -221,7 +221,7 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	del_timer_sync(&hte.timer);
+	timer_delete_sync(&hte.timer);
 }
 
 static struct platform_driver tegra_hte_test_driver = {
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 579d31b..d506a5e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -483,7 +483,7 @@ static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
 
-	del_timer_sync(&ctx->rpm_timer);
+	timer_delete_sync(&ctx->rpm_timer);
 	/* Switch off everything */
 	ctx->enable_mode = pwm_disable_reg_disable;
 	pwm_fan_power_off(ctx, true);
diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 02f75cf..5d8b82a 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1122,7 +1122,7 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		time_left = wait_for_completion_timeout(&i2c->msg_complete,
 						      IMG_I2C_TIMEOUT);
-		del_timer_sync(&i2c->check_timer);
+		timer_delete_sync(&i2c->check_timer);
 
 		if (time_left == 0)
 			i2c->msg_status = -ETIMEDOUT;
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 65f8a2b..22ea10e 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -190,7 +190,7 @@ static void ssp_enable_wdt_timer(struct ssp_data *data)
 
 static void ssp_disable_wdt_timer(struct ssp_data *data)
 {
-	del_timer_sync(&data->wdt_timer);
+	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
 }
 
@@ -589,7 +589,7 @@ static void ssp_remove(struct spi_device *spi)
 
 	free_irq(data->spi->irq, data);
 
-	del_timer_sync(&data->wdt_timer);
+	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
 
 	mutex_destroy(&data->comm_lock);
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8d753e6..e02721a 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -191,7 +191,7 @@ static void start_ep_timer(struct c4iw_ep *ep)
 static int stop_ep_timer(struct c4iw_ep *ep)
 {
 	pr_debug("ep %p stopping\n", ep);
-	del_timer_sync(&ep->timer);
+	timer_delete_sync(&ep->timer);
 	if (!test_and_set_bit(TIMEOUT, &ep->com.flags)) {
 		c4iw_put_ep(&ep->com);
 		return 0;
diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index a3c53be..9b508ea 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -191,7 +191,7 @@ void aspm_disable_all(struct hfi1_devdata *dd)
 	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
 		rcd = hfi1_rcd_get_by_index(dd, i);
 		if (rcd) {
-			del_timer_sync(&rcd->aspm_timer);
+			timer_delete_sync(&rcd->aspm_timer);
 			spin_lock_irqsave(&rcd->aspm_lock, flags);
 			rcd->aspm_intr_enable = false;
 			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 368b6be..e908f52 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5576,7 +5576,7 @@ static int init_rcverr(struct hfi1_devdata *dd)
 static void free_rcverr(struct hfi1_devdata *dd)
 {
 	if (dd->rcverr_timer.function)
-		del_timer_sync(&dd->rcverr_timer);
+		timer_delete_sync(&dd->rcverr_timer);
 }
 
 static void handle_rxe_err(struct hfi1_devdata *dd, u32 unused, u64 reg)
@@ -12308,7 +12308,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	int i;
 
 	if (dd->synth_stats_timer.function)
-		del_timer_sync(&dd->synth_stats_timer);
+		timer_delete_sync(&dd->synth_stats_timer);
 	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 50826e7..3da90f2 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1303,7 +1303,7 @@ void shutdown_led_override(struct hfi1_pportdata *ppd)
 	 */
 	smp_rmb();
 	if (atomic_read(&ppd->led_override_timer_active)) {
-		del_timer_sync(&ppd->led_override_timer);
+		timer_delete_sync(&ppd->led_override_timer);
 		atomic_set(&ppd->led_override_timer_active, 0);
 		/* Ensure the atomic_set is visible to all CPUs */
 		smp_wmb();
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index d6fbd9c..b35f92e 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -985,7 +985,7 @@ static void stop_timers(struct hfi1_devdata *dd)
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 		if (ppd->led_override_timer.function) {
-			del_timer_sync(&ppd->led_override_timer);
+			timer_delete_sync(&ppd->led_override_timer);
 			atomic_set(&ppd->led_override_timer_active, 0);
 		}
 	}
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index b67d23b..0d2b39b 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1575,7 +1575,7 @@ void sdma_exit(struct hfi1_devdata *dd)
 				   sde->this_idx);
 		sdma_process_event(sde, sdma_event_e00_go_hw_down);
 
-		del_timer_sync(&sde->err_progress_check_timer);
+		timer_delete_sync(&sde->err_progress_check_timer);
 
 		/*
 		 * This waits for the state machine to exit so it is not
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index c465966..78bf4a4 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -3965,7 +3965,7 @@ static int hfi1_stop_tid_reap_timer(struct rvt_qp *qp)
 
 	lockdep_assert_held(&qp->s_lock);
 	if (qpriv->s_flags & HFI1_R_TID_RSC_TIMER) {
-		rval = del_timer(&qpriv->s_tid_timer);
+		rval = timer_delete(&qpriv->s_tid_timer);
 		qpriv->s_flags &= ~HFI1_R_TID_RSC_TIMER;
 	}
 	return rval;
@@ -3975,7 +3975,7 @@ void hfi1_del_tid_reap_timer(struct rvt_qp *qp)
 {
 	struct hfi1_qp_priv *qpriv = qp->priv;
 
-	del_timer_sync(&qpriv->s_tid_timer);
+	timer_delete_sync(&qpriv->s_tid_timer);
 	qpriv->s_flags &= ~HFI1_R_TID_RSC_TIMER;
 }
 
@@ -4781,7 +4781,7 @@ static int hfi1_stop_tid_retry_timer(struct rvt_qp *qp)
 
 	lockdep_assert_held(&qp->s_lock);
 	if (priv->s_flags & HFI1_S_TID_RETRY_TIMER) {
-		rval = del_timer(&priv->s_tid_retry_timer);
+		rval = timer_delete(&priv->s_tid_retry_timer);
 		priv->s_flags &= ~HFI1_S_TID_RETRY_TIMER;
 	}
 	return rval;
@@ -4791,7 +4791,7 @@ void hfi1_del_tid_retry_timer(struct rvt_qp *qp)
 {
 	struct hfi1_qp_priv *priv = qp->priv;
 
-	del_timer_sync(&priv->s_tid_retry_timer);
+	timer_delete_sync(&priv->s_tid_retry_timer);
 	priv->s_flags &= ~HFI1_S_TID_RETRY_TIMER;
 }
 
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 33af219..49e0f79 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1900,7 +1900,7 @@ void hfi1_unregister_ib_device(struct hfi1_devdata *dd)
 	if (!list_empty(&dev->memwait))
 		dd_dev_err(dd, "memwait list not empty!\n");
 
-	del_timer_sync(&dev->mem_timer);
+	timer_delete_sync(&dev->mem_timer);
 	verbs_txreq_exit(dev);
 
 	kfree(dev_cntr_descs);
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index ce8d821..23207f1 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3303,7 +3303,7 @@ void irdma_cleanup_cm_core(struct irdma_cm_core *cm_core)
 	if (!cm_core)
 		return;
 
-	del_timer_sync(&cm_core->tcp_timer);
+	timer_delete_sync(&cm_core->tcp_timer);
 
 	destroy_workqueue(cm_core->event_wq);
 	cm_core->dev->ws_reset(&cm_core->iwdev->vsi);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index e73b14f..d66b4f7 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -963,7 +963,7 @@ void irdma_terminate_del_timer(struct irdma_sc_qp *qp)
 	int ret;
 
 	iwqp = qp->qp_uk.back_qp;
-	ret = del_timer(&iwqp->terminate_timer);
+	ret = timer_delete(&iwqp->terminate_timer);
 	if (ret)
 		irdma_qp_rem_ref(&iwqp->ibqp);
 }
@@ -1570,7 +1570,7 @@ void irdma_hw_stats_stop_timer(struct irdma_sc_vsi *vsi)
 {
 	struct irdma_vsi_pestat *devstat = vsi->pestat;
 
-	del_timer_sync(&devstat->stats_timer);
+	timer_delete_sync(&devstat->stats_timer);
 }
 
 /**
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b7c8c92..5fbebaf 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,7 +1026,7 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	mlx5r_destroy_cache_entries(dev);
 
 	destroy_workqueue(dev->cache.wq);
-	del_timer_sync(&dev->delay_timer);
+	timer_delete_sync(&dev->delay_timer);
 }
 
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
diff --git a/drivers/infiniband/hw/mthca/mthca_catas.c b/drivers/infiniband/hw/mthca/mthca_catas.c
index ffb98ea..6eabef9 100644
--- a/drivers/infiniband/hw/mthca/mthca_catas.c
+++ b/drivers/infiniband/hw/mthca/mthca_catas.c
@@ -171,7 +171,7 @@ void mthca_start_catas_poll(struct mthca_dev *dev)
 
 void mthca_stop_catas_poll(struct mthca_dev *dev)
 {
-	del_timer_sync(&dev->catas_err.timer);
+	timer_delete_sync(&dev->catas_err.timer);
 
 	if (dev->catas_err.map)
 		iounmap(dev->catas_err.map);
diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
index 4fcbef9..bdd724a 100644
--- a/drivers/infiniband/hw/qib/qib_driver.c
+++ b/drivers/infiniband/hw/qib/qib_driver.c
@@ -768,7 +768,7 @@ int qib_reset_device(int unit)
 		ppd = dd->pport + pidx;
 		if (atomic_read(&ppd->led_override_timer_active)) {
 			/* Need to stop LED timer, _then_ shut off LEDs */
-			del_timer_sync(&ppd->led_override_timer);
+			timer_delete_sync(&ppd->led_override_timer);
 			atomic_set(&ppd->led_override_timer_active, 0);
 		}
 
diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 78dfe98..302c0d1 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -1656,7 +1656,7 @@ static void qib_7220_quiet_serdes(struct qib_pportdata *ppd)
 
 	ppd->cpspec->chase_end = 0;
 	if (ppd->cpspec->chase_timer.function) /* if initted */
-		del_timer_sync(&ppd->cpspec->chase_timer);
+		timer_delete_sync(&ppd->cpspec->chase_timer);
 
 	if (ppd->cpspec->ibsymdelta || ppd->cpspec->iblnkerrdelta ||
 	    ppd->cpspec->ibdeltainprog) {
@@ -2605,7 +2605,7 @@ static int qib_7220_set_ib_cfg(struct qib_pportdata *ppd, int which, u32 val)
 			 * wait forpending timer, but don't clear .data (ppd)!
 			 */
 			if (ppd->cpspec->chase_timer.expires) {
-				del_timer_sync(&ppd->cpspec->chase_timer);
+				timer_delete_sync(&ppd->cpspec->chase_timer);
 				ppd->cpspec->chase_timer.expires = 0;
 			}
 			break;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 9db2991..7b4bf06 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -2512,7 +2512,7 @@ static void qib_7322_mini_quiet_serdes(struct qib_pportdata *ppd)
 
 	ppd->cpspec->chase_end = 0;
 	if (ppd->cpspec->chase_timer.function) /* if initted */
-		del_timer_sync(&ppd->cpspec->chase_timer);
+		timer_delete_sync(&ppd->cpspec->chase_timer);
 
 	/*
 	 * Despite the name, actually disables IBC as well. Do it when
@@ -4239,7 +4239,7 @@ static int qib_7322_set_ib_cfg(struct qib_pportdata *ppd, int which, u32 val)
 			 * wait forpending timer, but don't clear .data (ppd)!
 			 */
 			if (ppd->cpspec->chase_timer.expires) {
-				del_timer_sync(&ppd->cpspec->chase_timer);
+				timer_delete_sync(&ppd->cpspec->chase_timer);
 				ppd->cpspec->chase_timer.expires = 0;
 			}
 			break;
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 4100656..33c23ad 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -796,19 +796,19 @@ static void qib_stop_timers(struct qib_devdata *dd)
 	int pidx;
 
 	if (dd->stats_timer.function)
-		del_timer_sync(&dd->stats_timer);
+		timer_delete_sync(&dd->stats_timer);
 	if (dd->intrchk_timer.function)
-		del_timer_sync(&dd->intrchk_timer);
+		timer_delete_sync(&dd->intrchk_timer);
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
 		if (ppd->hol_timer.function)
-			del_timer_sync(&ppd->hol_timer);
+			timer_delete_sync(&ppd->hol_timer);
 		if (ppd->led_override_timer.function) {
-			del_timer_sync(&ppd->led_override_timer);
+			timer_delete_sync(&ppd->led_override_timer);
 			atomic_set(&ppd->led_override_timer_active, 0);
 		}
 		if (ppd->symerr_clear_timer.function)
-			del_timer_sync(&ppd->symerr_clear_timer);
+			timer_delete_sync(&ppd->symerr_clear_timer);
 	}
 }
 
diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index ef02f2b..568deb7 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2441,7 +2441,7 @@ void qib_notify_free_mad_agent(struct rvt_dev_info *rdi, int port_idx)
 					      struct qib_devdata, verbs_dev);
 
 	if (dd->pport[port_idx].cong_stats.timer.function)
-		del_timer_sync(&dd->pport[port_idx].cong_stats.timer);
+		timer_delete_sync(&dd->pport[port_idx].cong_stats.timer);
 
 	if (dd->pport[port_idx].ibport_data.smi_ah)
 		rdma_destroy_ah(&dd->pport[port_idx].ibport_data.smi_ah->ibah,
diff --git a/drivers/infiniband/hw/qib/qib_sd7220.c b/drivers/infiniband/hw/qib/qib_sd7220.c
index 1dc3ccf..c4ee120 100644
--- a/drivers/infiniband/hw/qib/qib_sd7220.c
+++ b/drivers/infiniband/hw/qib/qib_sd7220.c
@@ -1375,7 +1375,7 @@ void toggle_7220_rclkrls(struct qib_devdata *dd)
 void shutdown_7220_relock_poll(struct qib_devdata *dd)
 {
 	if (dd->cspec->relock_timer_active)
-		del_timer_sync(&dd->cspec->relock_timer);
+		timer_delete_sync(&dd->cspec->relock_timer);
 }
 
 static unsigned qib_relock_by_timer = 1;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 5fcb419..9832567 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1655,7 +1655,7 @@ void qib_unregister_ib_device(struct qib_devdata *dd)
 	if (!list_empty(&dev->memwait))
 		qib_dev_err(dd, "memwait list not empty!\n");
 
-	del_timer_sync(&dev->mem_timer);
+	timer_delete_sync(&dev->mem_timer);
 	while (!list_empty(&dev->txreq_free)) {
 		struct list_head *l = dev->txreq_free.next;
 		struct qib_verbs_txreq *tx;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 614009f..583debe 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1297,7 +1297,7 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 
 	if (qp->s_flags & (RVT_S_TIMER | RVT_S_WAIT_RNR)) {
 		qp->s_flags &= ~(RVT_S_TIMER | RVT_S_WAIT_RNR);
-		del_timer(&qp->s_timer);
+		timer_delete(&qp->s_timer);
 	}
 
 	if (qp->s_flags & RVT_S_ANY_WAIT_SEND)
@@ -2546,7 +2546,7 @@ void rvt_stop_rc_timers(struct rvt_qp *qp)
 	/* Remove QP from all timers */
 	if (qp->s_flags & (RVT_S_TIMER | RVT_S_WAIT_RNR)) {
 		qp->s_flags &= ~(RVT_S_TIMER | RVT_S_WAIT_RNR);
-		del_timer(&qp->s_timer);
+		timer_delete(&qp->s_timer);
 		hrtimer_try_to_cancel(&qp->s_rnr_timer);
 	}
 }
@@ -2575,7 +2575,7 @@ static void rvt_stop_rnr_timer(struct rvt_qp *qp)
  */
 void rvt_del_timers_sync(struct rvt_qp *qp)
 {
-	del_timer_sync(&qp->s_timer);
+	timer_delete_sync(&qp->s_timer);
 	hrtimer_cancel(&qp->s_rnr_timer);
 }
 EXPORT_SYMBOL(rvt_del_timers_sync);
@@ -2596,7 +2596,7 @@ static void rvt_rc_timeout(struct timer_list *t)
 
 		qp->s_flags &= ~RVT_S_TIMER;
 		rvp->n_rc_timeouts++;
-		del_timer(&qp->s_timer);
+		timer_delete(&qp->s_timer);
 		trace_rvt_rc_timeout(qp, qp->s_last_psn + 1);
 		if (rdi->driver_f.notify_restart_rc)
 			rdi->driver_f.notify_restart_rc(qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 91d329e..7975fb0 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -812,8 +812,8 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	qp->qp_timeout_jiffies = 0;
 
 	if (qp_type(qp) == IB_QPT_RC) {
-		del_timer_sync(&qp->retrans_timer);
-		del_timer_sync(&qp->rnr_nak_timer);
+		timer_delete_sync(&qp->retrans_timer);
+		timer_delete_sync(&qp->rnr_nak_timer);
 	}
 
 	if (qp->recv_task.func)
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index e9120ba..009822f 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -136,7 +136,7 @@ static void ml_schedule_timer(struct ml_device *ml)
 
 	if (!events) {
 		pr_debug("no actions\n");
-		del_timer(&ml->timer);
+		timer_delete(&ml->timer);
 	} else {
 		pr_debug("timer set\n");
 		mod_timer(&ml->timer, earliest);
@@ -489,7 +489,7 @@ static void ml_ff_destroy(struct ff_device *ff)
 	 * do not actually stop the timer, and therefore we should
 	 * do it here.
 	 */
-	del_timer_sync(&ml->timer);
+	timer_delete_sync(&ml->timer);
 
 	kfree(ml->private);
 }
diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 10cc958..ae51f10 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -191,7 +191,7 @@ void gameport_stop_polling(struct gameport *gameport)
 	spin_lock(&gameport->timer_lock);
 
 	if (!--gameport->poll_cnt)
-		del_timer(&gameport->poll_timer);
+		timer_delete(&gameport->poll_timer);
 
 	spin_unlock(&gameport->timer_lock);
 }
@@ -847,7 +847,7 @@ EXPORT_SYMBOL(gameport_open);
 
 void gameport_close(struct gameport *gameport)
 {
-	del_timer_sync(&gameport->poll_timer);
+	timer_delete_sync(&gameport->poll_timer);
 	gameport->poll_handler = NULL;
 	gameport->poll_interval = 0;
 	gameport_set_drv(gameport, NULL);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index c9e3ac6..ec4346f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -96,7 +96,7 @@ static void input_start_autorepeat(struct input_dev *dev, int code)
 
 static void input_stop_autorepeat(struct input_dev *dev)
 {
-	del_timer(&dev->timer);
+	timer_delete(&dev->timer);
 }
 
 /*
@@ -2223,7 +2223,7 @@ static void __input_unregister_device(struct input_dev *dev)
 			handle->handler->disconnect(handle);
 		WARN_ON(!list_empty(&dev->h_list));
 
-		del_timer_sync(&dev->timer);
+		timer_delete_sync(&dev->timer);
 		list_del_init(&dev->node);
 
 		input_wakeup_procfs_readers();
diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index a9f1946..d7a2538 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -531,7 +531,7 @@ static void db9_close(struct input_dev *dev)
 	guard(mutex)(&db9->mutex);
 
 	if (!--db9->used) {
-		del_timer_sync(&db9->timer);
+		timer_delete_sync(&db9->timer);
 		parport_write_control(port, 0x00);
 		parport_data_forward(port);
 		parport_release(db9->pd);
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index b53cafd..9fc629a 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -786,7 +786,7 @@ static void gc_close(struct input_dev *dev)
 	guard(mutex)(&gc->mutex);
 
 	if (!--gc->used) {
-		del_timer_sync(&gc->timer);
+		timer_delete_sync(&gc->timer);
 		parport_write_control(gc->pd->port, 0x00);
 		parport_release(gc->pd);
 	}
diff --git a/drivers/input/joystick/n64joy.c b/drivers/input/joystick/n64joy.c
index c344dbc..94d2f4e 100644
--- a/drivers/input/joystick/n64joy.c
+++ b/drivers/input/joystick/n64joy.c
@@ -216,7 +216,7 @@ static void n64joy_close(struct input_dev *dev)
 	guard(mutex)(&priv->n64joy_mutex);
 
 	if (!--priv->n64joy_opened)
-		del_timer_sync(&priv->timer);
+		timer_delete_sync(&priv->timer);
 }
 
 static const u64 __initconst scandata[] ____cacheline_aligned = {
diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index db696ba..aa3e7d4 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -124,7 +124,7 @@ static void tgfx_close(struct input_dev *dev)
 	guard(mutex)(&tgfx->sem);
 
 	if (!--tgfx->used) {
-		del_timer_sync(&tgfx->timer);
+		timer_delete_sync(&tgfx->timer);
 		parport_write_control(tgfx->pd->port, 0x00);
 		parport_release(tgfx->pd);
 	}
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index b92268d..3cd47fa 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -370,7 +370,7 @@ static void imx_keypad_close(struct input_dev *dev)
 	/* Mark keypad as being inactive */
 	keypad->enabled = false;
 	synchronize_irq(keypad->irq);
-	del_timer_sync(&keypad->check_matrix_timer);
+	timer_delete_sync(&keypad->check_matrix_timer);
 
 	imx_keypad_inhibit(keypad);
 
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index f7b5f1e..bbf409d 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -104,7 +104,7 @@ static void imx_snvs_pwrkey_act(void *pdata)
 {
 	struct pwrkey_drv_data *pd = pdata;
 
-	del_timer_sync(&pd->check_timer);
+	timer_delete_sync(&pd->check_timer);
 }
 
 static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 6776dd9..32a676f 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -416,7 +416,7 @@ static void tegra_kbc_stop(struct tegra_kbc *kbc)
 	}
 
 	disable_irq(kbc->irq);
-	del_timer_sync(&kbc->timer);
+	timer_delete_sync(&kbc->timer);
 
 	clk_disable_unprepare(kbc->clk);
 }
@@ -703,7 +703,7 @@ static int tegra_kbc_suspend(struct device *dev)
 
 	if (device_may_wakeup(&pdev->dev)) {
 		disable_irq(kbc->irq);
-		del_timer_sync(&kbc->timer);
+		timer_delete_sync(&kbc->timer);
 		tegra_kbc_set_fifo_interrupt(kbc, false);
 
 		/* Forcefully clear the interrupt status */
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0728b5c..0bd7b09 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1519,7 +1519,7 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		return PSMOUSE_GOOD_DATA;
 	}
 
-	del_timer(&priv->timer);
+	timer_delete(&priv->timer);
 
 	if (psmouse->packet[6] & 0x80) {
 
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 654b38d..4ee084e 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -425,7 +425,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		del_timer(&priv->timer);
+		timer_delete(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d36e89d..94e8bcb 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -1017,7 +1017,7 @@ static int __init hil_mlc_init(void)
 
 static void __exit hil_mlc_exit(void)
 {
-	del_timer_sync(&hil_mlcs_kicker);
+	timer_delete_sync(&hil_mlcs_kicker);
 	tasklet_kill(&hil_mlcs_tasklet);
 }
 
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 13eacf6..0eec4c5 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -980,7 +980,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	del_timer_sync(&hp_sdc.kicker);
+	timer_delete_sync(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index a0598e9..8d8392c 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -415,7 +415,7 @@ static void ad7877_disable(void *data)
 		ts->disabled = true;
 		disable_irq(ts->spi->irq);
 
-		if (del_timer_sync(&ts->timer))
+		if (timer_delete_sync(&ts->timer))
 			ad7877_ts_event_release(ts);
 	}
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e5d69bf..f661e19 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -273,7 +273,7 @@ static void __ad7879_disable(struct ad7879 *ts)
 		AD7879_PM(AD7879_PM_SHUTDOWN);
 	disable_irq(ts->irq);
 
-	if (del_timer_sync(&ts->timer))
+	if (timer_delete_sync(&ts->timer))
 		ad7879_ts_event_release(ts);
 
 	ad7879_write(ts, AD7879_REG_CTRL2, reg);
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index 686d0a6..3c997fb 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -325,7 +325,7 @@ static void bu21029_stop_chip(struct input_dev *dev)
 	struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
 
 	disable_irq(bu21029->client->irq);
-	del_timer_sync(&bu21029->timer);
+	timer_delete_sync(&bu21029->timer);
 
 	bu21029_put_chip_in_reset(bu21029);
 	regulator_disable(bu21029->vdd);
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index fdda841..9a5977d 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -174,7 +174,7 @@ static int exc3000_handle_mt_event(struct exc3000_data *data)
 	/*
 	 * We read full state successfully, no contacts will be "stuck".
 	 */
-	del_timer_sync(&data->timer);
+	timer_delete_sync(&data->timer);
 
 	while (total_slots > 0) {
 		int slots = min(total_slots, EXC3000_SLOTS_PER_FRAME);
diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index f5c5881..e59b8d0 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -290,7 +290,7 @@ static void sx8654_close(struct input_dev *dev)
 	disable_irq(client->irq);
 
 	if (!sx8654->data->has_irq_penrelease)
-		del_timer_sync(&sx8654->timer);
+		timer_delete_sync(&sx8654->timer);
 
 	/* enable manual mode mode */
 	error = i2c_smbus_write_byte(client, sx8654->data->cmd_manual);
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index df39dee..252a937 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -229,7 +229,7 @@ static void __tsc200x_disable(struct tsc200x *ts)
 
 	guard(disable_irq)(&ts->irq);
 
-	del_timer_sync(&ts->penup_timer);
+	timer_delete_sync(&ts->penup_timer);
 	cancel_delayed_work_sync(&ts->esd_work);
 }
 
@@ -388,7 +388,7 @@ static void tsc200x_esd_work(struct work_struct *work)
 		dev_info(ts->dev, "TSC200X not responding - resetting\n");
 
 		scoped_guard(disable_irq, &ts->irq) {
-			del_timer_sync(&ts->penup_timer);
+			timer_delete_sync(&ts->penup_timer);
 			tsc200x_update_pen_state(ts, 0, 0, 0);
 			tsc200x_reset(ts);
 		}
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6054d0a..cb7e29d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -271,7 +271,7 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 	if (!cookie->fq_domain)
 		return;
 
-	del_timer_sync(&cookie->fq_timer);
+	timer_delete_sync(&cookie->fq_timer);
 	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE)
 		iommu_dma_free_fq_single(cookie->single_fq);
 	else
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 45ff0e1..f6c27ca 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -3249,7 +3249,7 @@ hfcm_l1callback(struct dchannel *dch, u_int cmd)
 		}
 		test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 		if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-			del_timer(&dch->timer);
+			timer_delete(&dch->timer);
 		spin_unlock_irqrestore(&hc->lock, flags);
 		__skb_queue_purge(&free_queue);
 		break;
@@ -3394,7 +3394,7 @@ handle_dmsg(struct mISDNchannel *ch, struct sk_buff *skb)
 			}
 			test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 			if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-				del_timer(&dch->timer);
+				timer_delete(&dch->timer);
 #ifdef FIXME
 			if (test_and_clear_bit(FLG_L1_BUSY, &dch->Flags))
 				dchannel_sched_event(&hc->dch, D_CLEARBUSY);
@@ -4522,7 +4522,7 @@ release_port(struct hfc_multi *hc, struct dchannel *dch)
 	spin_lock_irqsave(&hc->lock, flags);
 
 	if (dch->timer.function) {
-		del_timer(&dch->timer);
+		timer_delete(&dch->timer);
 		dch->timer.function = NULL;
 	}
 
diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index ce7bccc..e3870d9 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -158,7 +158,7 @@ release_io_hfcpci(struct hfc_pci *hc)
 {
 	/* disable memory mapped ports + busmaster */
 	pci_write_config_word(hc->pdev, PCI_COMMAND, 0);
-	del_timer(&hc->hw.timer);
+	timer_delete(&hc->hw.timer);
 	dma_free_coherent(&hc->pdev->dev, 0x8000, hc->hw.fifos,
 			  hc->hw.dmahandle);
 	iounmap(hc->hw.pci_io);
@@ -1087,7 +1087,7 @@ hfc_l1callback(struct dchannel *dch, u_int cmd)
 		}
 		test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 		if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-			del_timer(&dch->timer);
+			timer_delete(&dch->timer);
 		break;
 	case HW_POWERUP_REQ:
 		Write_hfc(hc, HFCPCI_STATES, HFCPCI_DO_ACTION);
@@ -1216,7 +1216,7 @@ hfcpci_int(int intno, void *dev_id)
 		receive_dmsg(hc);
 	if (val & 0x04) {	/* D tx */
 		if (test_and_clear_bit(FLG_BUSY_TIMER, &hc->dch.Flags))
-			del_timer(&hc->dch.timer);
+			timer_delete(&hc->dch.timer);
 		tx_dirq(&hc->dch);
 	}
 	spin_unlock(&hc->lock);
@@ -1635,7 +1635,7 @@ hfcpci_l2l1D(struct mISDNchannel *ch, struct sk_buff *skb)
 			}
 			test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 			if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-				del_timer(&dch->timer);
+				timer_delete(&dch->timer);
 #ifdef FIXME
 			if (test_and_clear_bit(FLG_L1_BUSY, &dch->Flags))
 				dchannel_sched_event(&hc->dch, D_CLEARBUSY);
@@ -2064,7 +2064,7 @@ release_card(struct hfc_pci *hc) {
 	mode_hfcpci(&hc->bch[0], 1, ISDN_P_NONE);
 	mode_hfcpci(&hc->bch[1], 2, ISDN_P_NONE);
 	if (hc->dch.timer.function != NULL) {
-		del_timer(&hc->dch.timer);
+		timer_delete(&hc->dch.timer);
 		hc->dch.timer.function = NULL;
 	}
 	spin_unlock_irqrestore(&hc->lock, flags);
@@ -2342,7 +2342,7 @@ HFC_init(void)
 	err = pci_register_driver(&hfc_driver);
 	if (err) {
 		if (timer_pending(&hfc_tl))
-			del_timer(&hfc_tl);
+			timer_delete(&hfc_tl);
 	}
 
 	return err;
@@ -2351,7 +2351,7 @@ HFC_init(void)
 static void __exit
 HFC_cleanup(void)
 {
-	del_timer_sync(&hfc_tl);
+	timer_delete_sync(&hfc_tl);
 
 	pci_unregister_driver(&hfc_driver);
 }
diff --git a/drivers/isdn/hardware/mISDN/mISDNipac.c b/drivers/isdn/hardware/mISDN/mISDNipac.c
index d0b7271..165a639 100644
--- a/drivers/isdn/hardware/mISDN/mISDNipac.c
+++ b/drivers/isdn/hardware/mISDN/mISDNipac.c
@@ -158,7 +158,7 @@ isac_fill_fifo(struct isac_hw *isac)
 	WriteISAC(isac, ISAC_CMDR, more ? 0x8 : 0xa);
 	if (test_and_set_bit(FLG_BUSY_TIMER, &isac->dch.Flags)) {
 		pr_debug("%s: %s dbusytimer running\n", isac->name, __func__);
-		del_timer(&isac->dch.timer);
+		timer_delete(&isac->dch.timer);
 	}
 	isac->dch.timer.expires = jiffies + ((DBUSY_TIMER_VALUE * HZ)/1000);
 	add_timer(&isac->dch.timer);
@@ -206,7 +206,7 @@ static void
 isac_xpr_irq(struct isac_hw *isac)
 {
 	if (test_and_clear_bit(FLG_BUSY_TIMER, &isac->dch.Flags))
-		del_timer(&isac->dch.timer);
+		timer_delete(&isac->dch.timer);
 	if (isac->dch.tx_skb && isac->dch.tx_idx < isac->dch.tx_skb->len) {
 		isac_fill_fifo(isac);
 	} else {
@@ -220,7 +220,7 @@ static void
 isac_retransmit(struct isac_hw *isac)
 {
 	if (test_and_clear_bit(FLG_BUSY_TIMER, &isac->dch.Flags))
-		del_timer(&isac->dch.timer);
+		timer_delete(&isac->dch.timer);
 	if (test_bit(FLG_TX_BUSY, &isac->dch.Flags)) {
 		/* Restart frame */
 		isac->dch.tx_idx = 0;
@@ -665,7 +665,7 @@ isac_l1cmd(struct dchannel *dch, u32 cmd)
 		}
 		test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 		if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-			del_timer(&dch->timer);
+			timer_delete(&dch->timer);
 		break;
 	case HW_POWERUP_REQ:
 		spin_lock_irqsave(isac->hwlock, flags);
@@ -698,7 +698,7 @@ isac_release(struct isac_hw *isac)
 	else if (isac->type != 0)
 		WriteISAC(isac, ISAC_MASK, 0xff);
 	if (isac->dch.timer.function != NULL) {
-		del_timer(&isac->dch.timer);
+		timer_delete(&isac->dch.timer);
 		isac->dch.timer.function = NULL;
 	}
 	kfree(isac->mon_rx);
diff --git a/drivers/isdn/hardware/mISDN/mISDNisar.c b/drivers/isdn/hardware/mISDN/mISDNisar.c
index b3e03c4..e48f89c 100644
--- a/drivers/isdn/hardware/mISDN/mISDNisar.c
+++ b/drivers/isdn/hardware/mISDN/mISDNisar.c
@@ -930,7 +930,7 @@ isar_pump_statev_fax(struct isar_ch *ch, u8 devt) {
 				/* 1s (200 ms) Flags before data */
 				if (test_and_set_bit(FLG_FTI_RUN,
 						     &ch->bch.Flags))
-					del_timer(&ch->ftimer);
+					timer_delete(&ch->ftimer);
 				ch->ftimer.expires =
 					jiffies + ((delay * HZ) / 1000);
 				test_and_set_bit(FLG_LL_CONN,
@@ -1603,8 +1603,8 @@ free_isar(struct isar_hw *isar)
 {
 	modeisar(&isar->ch[0], ISDN_P_NONE);
 	modeisar(&isar->ch[1], ISDN_P_NONE);
-	del_timer(&isar->ch[0].ftimer);
-	del_timer(&isar->ch[1].ftimer);
+	timer_delete(&isar->ch[0].ftimer);
+	timer_delete(&isar->ch[1].ftimer);
 	test_and_clear_bit(FLG_INITIALIZED, &isar->ch[0].bch.Flags);
 	test_and_clear_bit(FLG_INITIALIZED, &isar->ch[1].bch.Flags);
 }
diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index ee69212..da933f4 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -294,7 +294,7 @@ W6692_fill_Dfifo(struct w6692_hw *card)
 	WriteW6692(card, W_D_CMDR, cmd);
 	if (test_and_set_bit(FLG_BUSY_TIMER, &dch->Flags)) {
 		pr_debug("%s: fill_Dfifo dbusytimer running\n", card->name);
-		del_timer(&dch->timer);
+		timer_delete(&dch->timer);
 	}
 	dch->timer.expires = jiffies + ((DBUSY_TIMER_VALUE * HZ) / 1000);
 	add_timer(&dch->timer);
@@ -311,7 +311,7 @@ d_retransmit(struct w6692_hw *card)
 	struct dchannel *dch = &card->dch;
 
 	if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-		del_timer(&dch->timer);
+		timer_delete(&dch->timer);
 #ifdef FIXME
 	if (test_and_clear_bit(FLG_L1_BUSY, &dch->Flags))
 		dchannel_sched_event(dch, D_CLEARBUSY);
@@ -372,7 +372,7 @@ handle_rxD(struct w6692_hw *card) {
 static void
 handle_txD(struct w6692_hw *card) {
 	if (test_and_clear_bit(FLG_BUSY_TIMER, &card->dch.Flags))
-		del_timer(&card->dch.timer);
+		timer_delete(&card->dch.timer);
 	if (card->dch.tx_skb && card->dch.tx_idx < card->dch.tx_skb->len) {
 		W6692_fill_Dfifo(card);
 	} else {
@@ -1130,7 +1130,7 @@ w6692_l1callback(struct dchannel *dch, u32 cmd)
 		}
 		test_and_clear_bit(FLG_TX_BUSY, &dch->Flags);
 		if (test_and_clear_bit(FLG_BUSY_TIMER, &dch->Flags))
-			del_timer(&dch->timer);
+			timer_delete(&dch->timer);
 		break;
 	case HW_POWERUP_REQ:
 		spin_lock_irqsave(&card->lock, flags);
diff --git a/drivers/isdn/mISDN/dsp_core.c b/drivers/isdn/mISDN/dsp_core.c
index 753232e..d0aa415 100644
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -928,7 +928,7 @@ dsp_function(struct mISDNchannel *ch,  struct sk_buff *skb)
 		dsp->tone.hardware = 0;
 		dsp->tone.software = 0;
 		if (timer_pending(&dsp->tone.tl))
-			del_timer(&dsp->tone.tl);
+			timer_delete(&dsp->tone.tl);
 		if (dsp->conf)
 			dsp_cmx_conf(dsp, 0); /* dsp_cmx_hardware will also be
 						 called here */
@@ -975,7 +975,7 @@ dsp_ctrl(struct mISDNchannel *ch, u_int cmd, void *arg)
 		cancel_work_sync(&dsp->workq);
 		spin_lock_irqsave(&dsp_lock, flags);
 		if (timer_pending(&dsp->tone.tl))
-			del_timer(&dsp->tone.tl);
+			timer_delete(&dsp->tone.tl);
 		skb_queue_purge(&dsp->sendq);
 		if (dsp_debug & DEBUG_DSP_CTRL)
 			printk(KERN_DEBUG "%s: releasing member %s\n",
@@ -1209,7 +1209,7 @@ static void __exit dsp_cleanup(void)
 {
 	mISDN_unregister_Bprotocol(&DSP);
 
-	del_timer_sync(&dsp_spl_tl);
+	timer_delete_sync(&dsp_spl_tl);
 
 	if (!list_empty(&dsp_ilist)) {
 		printk(KERN_ERR "mISDN_dsp: Audio DSP object inst list not "
diff --git a/drivers/isdn/mISDN/dsp_tones.c b/drivers/isdn/mISDN/dsp_tones.c
index 8389e21..456b313 100644
--- a/drivers/isdn/mISDN/dsp_tones.c
+++ b/drivers/isdn/mISDN/dsp_tones.c
@@ -505,7 +505,7 @@ dsp_tone(struct dsp *dsp, int tone)
 	/* we turn off the tone */
 	if (!tone) {
 		if (dsp->features.hfc_loops && timer_pending(&tonet->tl))
-			del_timer(&tonet->tl);
+			timer_delete(&tonet->tl);
 		if (dsp->features.hfc_loops)
 			dsp_tone_hw_message(dsp, NULL, 0);
 		tonet->tone = 0;
@@ -539,7 +539,7 @@ dsp_tone(struct dsp *dsp, int tone)
 		dsp_tone_hw_message(dsp, pat->data[0], *(pat->siz[0]));
 		/* set timer */
 		if (timer_pending(&tonet->tl))
-			del_timer(&tonet->tl);
+			timer_delete(&tonet->tl);
 		tonet->tl.expires = jiffies + (pat->seq[0] * HZ) / 8000;
 		add_timer(&tonet->tl);
 	} else {
diff --git a/drivers/isdn/mISDN/fsm.c b/drivers/isdn/mISDN/fsm.c
index 7c5c2ca..5ed0a61 100644
--- a/drivers/isdn/mISDN/fsm.c
+++ b/drivers/isdn/mISDN/fsm.c
@@ -123,7 +123,7 @@ mISDN_FsmDelTimer(struct FsmTimer *ft, int where)
 		ft->fi->printdebug(ft->fi, "mISDN_FsmDelTimer %lx %d",
 				   (long) ft, where);
 #endif
-	del_timer(&ft->tl);
+	timer_delete(&ft->tl);
 }
 EXPORT_SYMBOL(mISDN_FsmDelTimer);
 
@@ -167,7 +167,7 @@ mISDN_FsmRestartTimer(struct FsmTimer *ft,
 #endif
 
 	if (timer_pending(&ft->tl))
-		del_timer(&ft->tl);
+		timer_delete(&ft->tl);
 	ft->event = event;
 	ft->arg = arg;
 	ft->tl.expires = jiffies + (millisec * HZ) / 1000;
diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
index 6b051f1..32ba397 100644
--- a/drivers/leds/flash/leds-rt8515.c
+++ b/drivers/leds/flash/leds-rt8515.c
@@ -127,7 +127,7 @@ static int rt8515_led_flash_strobe_set(struct led_classdev_flash *fled,
 		mod_timer(&rt->powerdown_timer,
 			  jiffies + usecs_to_jiffies(timeout->val));
 	} else {
-		del_timer_sync(&rt->powerdown_timer);
+		timer_delete_sync(&rt->powerdown_timer);
 		/* Turn the LED off */
 		rt8515_gpio_led_off(rt);
 	}
@@ -372,7 +372,7 @@ static void rt8515_remove(struct platform_device *pdev)
 	struct rt8515 *rt = platform_get_drvdata(pdev);
 
 	rt8515_v4l2_flash_release(rt);
-	del_timer_sync(&rt->powerdown_timer);
+	timer_delete_sync(&rt->powerdown_timer);
 	mutex_destroy(&rt->lock);
 }
 
diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index 3c01739..48fb8a9 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -55,7 +55,7 @@ static int sgm3140_strobe_set(struct led_classdev_flash *fled_cdev, bool state)
 		mod_timer(&priv->powerdown_timer,
 			  jiffies + usecs_to_jiffies(priv->timeout));
 	} else {
-		del_timer_sync(&priv->powerdown_timer);
+		timer_delete_sync(&priv->powerdown_timer);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
@@ -117,7 +117,7 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
-		del_timer_sync(&priv->powerdown_timer);
+		timer_delete_sync(&priv->powerdown_timer);
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
@@ -285,7 +285,7 @@ static void sgm3140_remove(struct platform_device *pdev)
 {
 	struct sgm3140 *priv = platform_get_drvdata(pdev);
 
-	del_timer_sync(&priv->powerdown_timer);
+	timer_delete_sync(&priv->powerdown_timer);
 
 	v4l2_flash_release(priv->v4l2_flash);
 }
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index e3d8ddc..907fc70 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -245,7 +245,7 @@ void led_blink_set(struct led_classdev *led_cdev,
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	timer_delete_sync(&led_cdev->blink_timer);
 
 	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
 	clear_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags);
@@ -294,7 +294,7 @@ EXPORT_SYMBOL_GPL(led_blink_set_nosleep);
 
 void led_stop_software_blink(struct led_classdev *led_cdev)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	timer_delete_sync(&led_cdev->blink_timer);
 	led_cdev->blink_delay_on = 0;
 	led_cdev->blink_delay_off = 0;
 	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index a594bd5..06d0529 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -94,7 +94,7 @@ static void pattern_trig_timer_cancel(struct pattern_trig_data *data)
 	if (data->type == PATTERN_TYPE_HR)
 		hrtimer_cancel(&data->hrtimer);
 	else
-		del_timer_sync(&data->timer);
+		timer_delete_sync(&data->timer);
 }
 
 static void pattern_trig_timer_restart(struct pattern_trig_data *data,
diff --git a/drivers/leds/trigger/ledtrig-transient.c b/drivers/leds/trigger/ledtrig-transient.c
index f111fa7..e103c7e 100644
--- a/drivers/leds/trigger/ledtrig-transient.c
+++ b/drivers/leds/trigger/ledtrig-transient.c
@@ -66,7 +66,7 @@ static ssize_t transient_activate_store(struct device *dev,
 
 	/* cancel the running timer */
 	if (state == 0 && transient_data->activate == 1) {
-		del_timer(&transient_data->timer);
+		timer_delete(&transient_data->timer);
 		transient_data->activate = state;
 		led_set_brightness_nosleep(led_cdev,
 					transient_data->restore_state);
diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index b2fe7a3..c5aabf2 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -724,7 +724,7 @@ adb_message_handler(struct notifier_block *this, unsigned long code, void *x)
 			int i;
 			for (i = 1; i < 16; i++) {
 				if (adbhid[i])
-					del_timer_sync(&adbhid[i]->input->timer);
+					timer_delete_sync(&adbhid[i]->input->timer);
 			}
 		}
 
diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index afb320e..7481286 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -270,7 +270,7 @@ static void altera_mbox_shutdown(struct mbox_chan *chan)
 		writel_relaxed(~0, mbox->mbox_base + MAILBOX_INTMASK_REG);
 		free_irq(mbox->irq, chan);
 	} else if (!mbox->is_sender) {
-		del_timer_sync(&mbox->rxpoll_timer);
+		timer_delete_sync(&mbox->rxpoll_timer);
 	}
 }
 
diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index 68b0221..d39dec3 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -123,7 +123,7 @@ void bch_cache_accounting_destroy(struct cache_accounting *acc)
 	kobject_put(&acc->day.kobj);
 
 	atomic_set(&acc->closing, 1);
-	if (del_timer_sync(&acc->timer))
+	if (timer_delete_sync(&acc->timer))
 		closure_return(&acc->cl);
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 8b219b1..2a283fe 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2707,7 +2707,7 @@ static void integrity_commit(struct work_struct *w)
 	unsigned int i, j, n;
 	struct bio *flushes;
 
-	del_timer(&ic->autocommit_timer);
+	timer_delete(&ic->autocommit_timer);
 
 	if (ic->mode == 'I')
 		return;
@@ -3606,7 +3606,7 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 
 	WARN_ON(unregister_reboot_notifier(&ic->reboot_notifier));
 
-	del_timer_sync(&ic->autocommit_timer);
+	timer_delete_sync(&ic->autocommit_timer);
 
 	if (ic->recalc_wq)
 		drain_workqueue(ic->recalc_wq);
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 637977a..6c98f4a 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -815,7 +815,7 @@ static void enable_nopath_timeout(struct multipath *m)
 
 static void disable_nopath_timeout(struct multipath *m)
 {
-	del_timer_sync(&m->nopath_timer);
+	timer_delete_sync(&m->nopath_timer);
 }
 
 /*
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 8c6f1f7..9e615b4 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -1182,7 +1182,7 @@ static void mirror_dtr(struct dm_target *ti)
 {
 	struct mirror_set *ms = ti->private;
 
-	del_timer_sync(&ms->timer);
+	timer_delete_sync(&ms->timer);
 	flush_workqueue(ms->kmirrord_wq);
 	flush_work(&ms->trigger_event);
 	dm_kcopyd_client_destroy(ms->kcopyd_client);
diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
index 5c49d49..3c58b94 100644
--- a/drivers/md/dm-vdo/dedupe.c
+++ b/drivers/md/dm-vdo/dedupe.c
@@ -2261,7 +2261,7 @@ static void check_for_drain_complete(struct hash_zone *zone)
 	if ((atomic_read(&zone->timer_state) == DEDUPE_QUERY_TIMER_IDLE) ||
 	    change_timer_state(zone, DEDUPE_QUERY_TIMER_RUNNING,
 			       DEDUPE_QUERY_TIMER_IDLE)) {
-		del_timer_sync(&zone->timer);
+		timer_delete_sync(&zone->timer);
 	} else {
 		/*
 		 * There is an in flight time-out, which must get processed before we can continue.
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 7ce8847..d6a04a5 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -797,7 +797,7 @@ static void writecache_flush(struct dm_writecache *wc)
 	bool need_flush_after_free;
 
 	wc->uncommitted_blocks = 0;
-	del_timer(&wc->autocommit_timer);
+	timer_delete(&wc->autocommit_timer);
 
 	if (list_empty(&wc->lru))
 		return;
@@ -927,8 +927,8 @@ static void writecache_suspend(struct dm_target *ti)
 	struct dm_writecache *wc = ti->private;
 	bool flush_on_suspend;
 
-	del_timer_sync(&wc->autocommit_timer);
-	del_timer_sync(&wc->max_age_timer);
+	timer_delete_sync(&wc->autocommit_timer);
+	timer_delete_sync(&wc->max_age_timer);
 
 	wc_lock(wc);
 	writecache_flush(wc);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 438e71e..9daa78c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4064,7 +4064,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 		 * it must always be in_sync
 		 */
 		mddev->in_sync = 1;
-		del_timer_sync(&mddev->safemode_timer);
+		timer_delete_sync(&mddev->safemode_timer);
 	}
 	pers->run(mddev);
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
@@ -6405,7 +6405,7 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	del_timer_sync(&mddev->safemode_timer);
+	timer_delete_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
 		mddev->pers->quiesce(mddev, 1);
diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index a7047e5..2952678 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -147,7 +147,7 @@ void saa7146_buffer_next(struct saa7146_dev *dev,
 			printk("vdma%d.num_line_byte: 0x%08x\n", 1,saa7146_read(dev,NUM_LINE_BYTE1));
 */
 		}
-		del_timer(&q->timeout);
+		timer_delete(&q->timeout);
 	}
 }
 
diff --git a/drivers/media/common/saa7146/saa7146_vbi.c b/drivers/media/common/saa7146/saa7146_vbi.c
index a1854b3..6c324a6 100644
--- a/drivers/media/common/saa7146/saa7146_vbi.c
+++ b/drivers/media/common/saa7146/saa7146_vbi.c
@@ -322,8 +322,8 @@ static void vbi_stop(struct saa7146_dev *dev)
 	/* shut down dma 3 transfers */
 	saa7146_write(dev, MC1, MASK_20);
 
-	del_timer(&vv->vbi_dmaq.timeout);
-	del_timer(&vv->vbi_read_timeout);
+	timer_delete(&vv->vbi_dmaq.timeout);
+	timer_delete(&vv->vbi_read_timeout);
 
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
diff --git a/drivers/media/common/saa7146/saa7146_video.c b/drivers/media/common/saa7146/saa7146_video.c
index 94e1cd4..733e180 100644
--- a/drivers/media/common/saa7146/saa7146_video.c
+++ b/drivers/media/common/saa7146/saa7146_video.c
@@ -668,7 +668,7 @@ static void stop_streaming(struct vb2_queue *q)
 	struct saa7146_dev *dev = vb2_get_drv_priv(q);
 	struct saa7146_dmaqueue *dq = &dev->vv_data->video_dmaq;
 
-	del_timer(&dq->timeout);
+	timer_delete(&dq->timeout);
 	video_end(dev);
 	return_buffers(q, VB2_BUF_STATE_ERROR);
 }
diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 6063782..1e985f9 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -365,7 +365,7 @@ static void dvb_dmxdev_filter_timer(struct dmxdev_filter *dmxdevfilter)
 {
 	struct dmx_sct_filter_params *para = &dmxdevfilter->params.sec;
 
-	del_timer(&dmxdevfilter->timer);
+	timer_delete(&dmxdevfilter->timer);
 	if (para->timeout) {
 		dmxdevfilter->timer.expires =
 		    jiffies + 1 + (HZ / 2 + HZ * para->timeout) / 1000;
@@ -391,7 +391,7 @@ static int dvb_dmxdev_section_callback(const u8 *buffer1, size_t buffer1_len,
 		spin_unlock(&dmxdevfilter->dev->lock);
 		return 0;
 	}
-	del_timer(&dmxdevfilter->timer);
+	timer_delete(&dmxdevfilter->timer);
 	dprintk("section callback %*ph\n", 6, buffer1);
 	if (dvb_vb2_is_streaming(&dmxdevfilter->vb2_ctx)) {
 		ret = dvb_vb2_fill_buffer(&dmxdevfilter->vb2_ctx,
@@ -482,7 +482,7 @@ static int dvb_dmxdev_feed_stop(struct dmxdev_filter *dmxdevfilter)
 
 	switch (dmxdevfilter->type) {
 	case DMXDEV_TYPE_SEC:
-		del_timer(&dmxdevfilter->timer);
+		timer_delete(&dmxdevfilter->timer);
 		dmxdevfilter->feed.sec->stop_filtering(dmxdevfilter->feed.sec);
 		break;
 	case DMXDEV_TYPE_PES:
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index c50d4e8..2d5f42f 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2201,7 +2201,7 @@ static int tc358743_probe(struct i2c_client *client)
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
 	if (!state->i2c_client->irq) {
-		del_timer(&state->timer);
+		timer_delete(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
 	cancel_delayed_work(&state->delayed_work_enable_hotplug);
@@ -2218,7 +2218,7 @@ static void tc358743_remove(struct i2c_client *client)
 	struct tc358743_state *state = to_state(sd);
 
 	if (!state->i2c_client->irq) {
-		del_timer_sync(&state->timer);
+		timer_delete_sync(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
 	cancel_delayed_work_sync(&state->delayed_work_enable_hotplug);
diff --git a/drivers/media/i2c/tvaudio.c b/drivers/media/i2c/tvaudio.c
index 654725d..4211511 100644
--- a/drivers/media/i2c/tvaudio.c
+++ b/drivers/media/i2c/tvaudio.c
@@ -1787,7 +1787,7 @@ static int tvaudio_s_radio(struct v4l2_subdev *sd)
 	struct CHIPSTATE *chip = to_state(sd);
 
 	chip->radio = 1;
-	/* del_timer(&chip->wt); */
+	/* timer_delete(&chip->wt); */
 	return 0;
 }
 
@@ -2071,7 +2071,7 @@ static void tvaudio_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct CHIPSTATE *chip = to_state(sd);
 
-	del_timer_sync(&chip->wt);
+	timer_delete_sync(&chip->wt);
 	if (chip->thread) {
 		/* shutdown async thread */
 		kthread_stop(chip->thread);
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 2782832..377a7e7 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -3491,7 +3491,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
-	del_timer_sync(&btv->timeout);
+	timer_delete_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
diff --git a/drivers/media/pci/bt8xx/bttv-input.c b/drivers/media/pci/bt8xx/bttv-input.c
index 41226f1..9eb7a53 100644
--- a/drivers/media/pci/bt8xx/bttv-input.c
+++ b/drivers/media/pci/bt8xx/bttv-input.c
@@ -304,12 +304,12 @@ static void bttv_ir_start(struct bttv_ir *ir)
 static void bttv_ir_stop(struct bttv *btv)
 {
 	if (btv->remote->polling)
-		del_timer_sync(&btv->remote->timer);
+		timer_delete_sync(&btv->remote->timer);
 
 	if (btv->remote->rc5_gpio) {
 		u32 gpio;
 
-		del_timer_sync(&btv->remote->timer);
+		timer_delete_sync(&btv->remote->timer);
 
 		gpio = bttv_gpio_read(&btv->c);
 		bttv_gpio_write(&btv->c, gpio & ~(1 << 4));
diff --git a/drivers/media/pci/bt8xx/bttv-risc.c b/drivers/media/pci/bt8xx/bttv-risc.c
index 241a696..79581cd 100644
--- a/drivers/media/pci/bt8xx/bttv-risc.c
+++ b/drivers/media/pci/bt8xx/bttv-risc.c
@@ -376,7 +376,7 @@ static void bttv_set_irq_timer(struct bttv *btv)
 	if (btv->curr.frame_irq || btv->loop_irq || btv->cvbi)
 		mod_timer(&btv->timeout, jiffies + BTTV_TIMEOUT);
 	else
-		del_timer(&btv->timeout);
+		timer_delete(&btv->timeout);
 }
 
 static int bttv_set_capture_control(struct bttv *btv, int start_capture)
diff --git a/drivers/media/pci/ivtv/ivtv-irq.c b/drivers/media/pci/ivtv/ivtv-irq.c
index b7aaa8b..b3b670b 100644
--- a/drivers/media/pci/ivtv/ivtv-irq.c
+++ b/drivers/media/pci/ivtv/ivtv-irq.c
@@ -532,7 +532,7 @@ static void ivtv_irq_dma_read(struct ivtv *itv)
 
 	IVTV_DEBUG_HI_IRQ("DEC DMA READ\n");
 
-	del_timer(&itv->dma_timer);
+	timer_delete(&itv->dma_timer);
 
 	if (!test_bit(IVTV_F_I_UDMA, &itv->i_flags) && itv->cur_dma_stream < 0)
 		return;
@@ -597,7 +597,7 @@ static void ivtv_irq_enc_dma_complete(struct ivtv *itv)
 	ivtv_api_get_data(&itv->enc_mbox, IVTV_MBOX_DMA_END, 2, data);
 	IVTV_DEBUG_HI_IRQ("ENC DMA COMPLETE %x %d (%d)\n", data[0], data[1], itv->cur_dma_stream);
 
-	del_timer(&itv->dma_timer);
+	timer_delete(&itv->dma_timer);
 
 	if (itv->cur_dma_stream < 0)
 		return;
@@ -670,7 +670,7 @@ static void ivtv_irq_dma_err(struct ivtv *itv)
 	u32 data[CX2341X_MBOX_MAX_DATA];
 	u32 status;
 
-	del_timer(&itv->dma_timer);
+	timer_delete(&itv->dma_timer);
 
 	ivtv_api_get_data(&itv->enc_mbox, IVTV_MBOX_DMA_END, 2, data);
 	status = read_reg(IVTV_REG_DMASTATUS);
diff --git a/drivers/media/pci/ivtv/ivtv-streams.c b/drivers/media/pci/ivtv/ivtv-streams.c
index af9e623..ac08592 100644
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -891,7 +891,7 @@ int ivtv_stop_v4l2_encode_stream(struct ivtv_stream *s, int gop_end)
 
 	/* Set the following Interrupt mask bits for capture */
 	ivtv_set_irq_mask(itv, IVTV_IRQ_MASK_CAPTURE);
-	del_timer(&itv->dma_timer);
+	timer_delete(&itv->dma_timer);
 
 	/* event notification (off) */
 	if (test_and_clear_bit(IVTV_F_I_DIG_RST, &itv->i_flags)) {
@@ -956,7 +956,7 @@ int ivtv_stop_v4l2_decode_stream(struct ivtv_stream *s, int flags, u64 pts)
 	ivtv_vapi(itv, CX2341X_DEC_SET_EVENT_NOTIFICATION, 4, 0, 0, IVTV_IRQ_DEC_AUD_MODE_CHG, -1);
 
 	ivtv_set_irq_mask(itv, IVTV_IRQ_MASK_DECODE);
-	del_timer(&itv->dma_timer);
+	timer_delete(&itv->dma_timer);
 
 	clear_bit(IVTV_F_S_NEEDS_DATA, &s->s_flags);
 	clear_bit(IVTV_F_S_STREAMING, &s->s_flags);
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 557985b..16338d1 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -698,7 +698,7 @@ static void netup_unidvb_dma_fini(struct netup_unidvb_dev *ndev, int num)
 	netup_unidvb_dma_enable(dma, 0);
 	msleep(50);
 	cancel_work_sync(&dma->work);
-	del_timer_sync(&dma->timeout);
+	timer_delete_sync(&dma->timeout);
 }
 
 static int netup_unidvb_dma_setup(struct netup_unidvb_dev *ndev)
diff --git a/drivers/media/pci/saa7134/saa7134-core.c b/drivers/media/pci/saa7134/saa7134-core.c
index ea0585e..84295bd 100644
--- a/drivers/media/pci/saa7134/saa7134-core.c
+++ b/drivers/media/pci/saa7134/saa7134-core.c
@@ -322,7 +322,7 @@ void saa7134_buffer_next(struct saa7134_dev *dev,
 		/* nothing to do -- just stop DMA */
 		core_dbg("buffer_next %p\n", NULL);
 		saa7134_set_dmabits(dev);
-		del_timer(&q->timeout);
+		timer_delete(&q->timeout);
 	}
 }
 
@@ -364,7 +364,7 @@ void saa7134_stop_streaming(struct saa7134_dev *dev, struct saa7134_dmaqueue *q)
 		tmp = NULL;
 	}
 	spin_unlock_irqrestore(&dev->slock, flags);
-	saa7134_buffer_timeout(&q->timeout); /* also calls del_timer(&q->timeout) */
+	saa7134_buffer_timeout(&q->timeout); /* also calls timer_delete(&q->timeout) */
 }
 EXPORT_SYMBOL_GPL(saa7134_stop_streaming);
 
@@ -1390,9 +1390,9 @@ static int __maybe_unused saa7134_suspend(struct device *dev_d)
 	/* Disable timeout timers - if we have active buffers, we will
 	   fill them on resume*/
 
-	del_timer(&dev->video_q.timeout);
-	del_timer(&dev->vbi_q.timeout);
-	del_timer(&dev->ts_q.timeout);
+	timer_delete(&dev->video_q.timeout);
+	timer_delete(&dev->vbi_q.timeout);
+	timer_delete(&dev->ts_q.timeout);
 
 	if (dev->remote && dev->remote->dev->users)
 		saa7134_ir_close(dev->remote->dev);
diff --git a/drivers/media/pci/saa7134/saa7134-input.c b/drivers/media/pci/saa7134/saa7134-input.c
index 8610eb4..d7d97c7 100644
--- a/drivers/media/pci/saa7134/saa7134-input.c
+++ b/drivers/media/pci/saa7134/saa7134-input.c
@@ -496,7 +496,7 @@ void saa7134_ir_close(struct rc_dev *rc)
 	struct saa7134_card_ir *ir = dev->remote;
 
 	if (ir->polling)
-		del_timer_sync(&ir->timer);
+		timer_delete_sync(&ir->timer);
 
 	ir->running = false;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index ec699ea..1b44033 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -298,7 +298,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
-	del_timer_sync(&dev->ts_q.timeout);
+	timer_delete_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index efa6e4f..28bf774 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -183,7 +183,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
-	del_timer_sync(&dev->vbi_q.timeout);
+	timer_delete_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 43e7b00..c88939b 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -1741,7 +1741,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
-	del_timer_sync(&dev->video_q.timeout);
+	timer_delete_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
index c53099c..80bd268 100644
--- a/drivers/media/pci/tw686x/tw686x-core.c
+++ b/drivers/media/pci/tw686x/tw686x-core.c
@@ -373,7 +373,7 @@ static void tw686x_remove(struct pci_dev *pci_dev)
 
 	tw686x_video_free(dev);
 	tw686x_audio_free(dev);
-	del_timer_sync(&dev->dma_delay_timer);
+	timer_delete_sync(&dev->dma_delay_timer);
 
 	pci_iounmap(pci_dev, dev->mmio);
 	pci_release_regions(pci_dev);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 5f80931..c8e0ee3 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -935,7 +935,7 @@ err_pwr_enable:
 	if (dev->num_inst == 1) {
 		if (s5p_mfc_power_off(dev) < 0)
 			mfc_err("power off failed\n");
-		del_timer_sync(&dev->watchdog_timer);
+		timer_delete_sync(&dev->watchdog_timer);
 	}
 err_ctrls_setup:
 	s5p_mfc_dec_ctrls_delete(ctx);
@@ -985,7 +985,7 @@ static int s5p_mfc_release(struct file *file)
 		if (dev->num_inst == 0) {
 			mfc_debug(2, "Last instance\n");
 			s5p_mfc_deinit_hw(dev);
-			del_timer_sync(&dev->watchdog_timer);
+			timer_delete_sync(&dev->watchdog_timer);
 			s5p_mfc_clock_off(dev);
 			if (s5p_mfc_power_off(dev) < 0)
 				mfc_err("Power off failed\n");
@@ -1461,7 +1461,7 @@ static void s5p_mfc_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&dev->mfc_mutex);
 
-	del_timer_sync(&dev->watchdog_timer);
+	timer_delete_sync(&dev->watchdog_timer);
 	flush_work(&dev->watchdog_work);
 
 	video_unregister_device(dev->vfd_enc);
diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index d151d2e..87a817d 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -351,7 +351,7 @@ static int c8sectpfe_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 		dev_dbg(fei->dev, "%s:%d global_feed_count=%d\n"
 			, __func__, __LINE__, fei->global_feed_count);
 
-		del_timer(&fei->timer);
+		timer_delete(&fei->timer);
 	}
 
 	mutex_unlock(&fei->lock);
diff --git a/drivers/media/radio/radio-cadet.c b/drivers/media/radio/radio-cadet.c
index a5db9b4..2ddf1df 100644
--- a/drivers/media/radio/radio-cadet.c
+++ b/drivers/media/radio/radio-cadet.c
@@ -471,7 +471,7 @@ static int cadet_release(struct file *file)
 
 	mutex_lock(&dev->lock);
 	if (v4l2_fh_is_singular_file(file) && dev->rdsstat) {
-		del_timer_sync(&dev->readtimer);
+		timer_delete_sync(&dev->readtimer);
 		dev->rdsstat = 0;
 	}
 	v4l2_fh_release(file);
diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 67722e2..9435cba 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1104,7 +1104,7 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	unsigned long flags;
 
 	rc_unregister_device(dev->rdev);
-	del_timer_sync(&dev->tx_sim_timer);
+	timer_delete_sync(&dev->tx_sim_timer);
 	spin_lock_irqsave(&dev->hw_lock, flags);
 	ene_rx_disable(dev);
 	ene_rx_restore_hw_buffer(dev);
diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 1464ef9..bfe8658 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -223,7 +223,7 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	return 0;
 fail:
 	usb_poison_urb(ir->urb);
-	del_timer(&ir->timer);
+	timer_delete(&ir->timer);
 	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
 	rc_free_device(ir->rc);
@@ -238,7 +238,7 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 
 	rc_unregister_device(ir->rc);
 	usb_poison_urb(ir->urb);
-	del_timer_sync(&ir->timer);
+	timer_delete_sync(&ir->timer);
 	usb_set_intfdata(intf, NULL);
 	usb_unpoison_urb(ir->urb);
 	usb_free_urb(ir->urb);
diff --git a/drivers/media/rc/img-ir/img-ir-hw.c b/drivers/media/rc/img-ir/img-ir-hw.c
index 5da7479..da89ddf 100644
--- a/drivers/media/rc/img-ir/img-ir-hw.c
+++ b/drivers/media/rc/img-ir/img-ir-hw.c
@@ -556,8 +556,8 @@ static void img_ir_set_decoder(struct img_ir_priv *priv,
 	 * acquires the lock and we don't want to deadlock waiting for it.
 	 */
 	spin_unlock_irq(&priv->lock);
-	del_timer_sync(&hw->end_timer);
-	del_timer_sync(&hw->suspend_timer);
+	timer_delete_sync(&hw->end_timer);
+	timer_delete_sync(&hw->suspend_timer);
 	spin_lock_irq(&priv->lock);
 
 	hw->stopping = false;
diff --git a/drivers/media/rc/img-ir/img-ir-raw.c b/drivers/media/rc/img-ir/img-ir-raw.c
index 8b0bdd9..669f330 100644
--- a/drivers/media/rc/img-ir/img-ir-raw.c
+++ b/drivers/media/rc/img-ir/img-ir-raw.c
@@ -147,5 +147,5 @@ void img_ir_remove_raw(struct img_ir_priv *priv)
 
 	rc_unregister_device(rdev);
 
-	del_timer_sync(&raw->timer);
+	timer_delete_sync(&raw->timer);
 }
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 8f1361b..cb6f36e 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2534,7 +2534,7 @@ static void imon_disconnect(struct usb_interface *interface)
 		ictx->dev_present_intf1 = false;
 		usb_kill_urb(ictx->rx_urb_intf1);
 		if (ictx->display_type == IMON_DISPLAY_TYPE_VGA) {
-			del_timer_sync(&ictx->ttimer);
+			timer_delete_sync(&ictx->ttimer);
 			input_unregister_device(ictx->touch);
 		}
 		usb_put_dev(ictx->usbdev_intf1);
diff --git a/drivers/media/rc/ir-mce_kbd-decoder.c b/drivers/media/rc/ir-mce_kbd-decoder.c
index 66e8feb..817030f 100644
--- a/drivers/media/rc/ir-mce_kbd-decoder.c
+++ b/drivers/media/rc/ir-mce_kbd-decoder.c
@@ -324,7 +324,7 @@ again:
 					msecs_to_jiffies(100);
 				mod_timer(&data->rx_timeout, jiffies + delay);
 			} else {
-				del_timer(&data->rx_timeout);
+				timer_delete(&data->rx_timeout);
 			}
 			/* Pass data to keyboard buffer parser */
 			ir_mce_kbd_process_keyboard_data(dev, scancode);
@@ -372,7 +372,7 @@ static int ir_mce_kbd_unregister(struct rc_dev *dev)
 {
 	struct mce_kbd_dec *mce_kbd = &dev->raw->mce_kbd;
 
-	del_timer_sync(&mce_kbd->rx_timeout);
+	timer_delete_sync(&mce_kbd->rx_timeout);
 
 	return 0;
 }
diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 16e33d7..aa4ac43 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -662,7 +662,7 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 		return;
 
 	kthread_stop(dev->raw->thread);
-	del_timer_sync(&dev->raw->edge_handle);
+	timer_delete_sync(&dev->raw->edge_handle);
 
 	mutex_lock(&ir_raw_handler_lock);
 	list_del(&dev->raw->list);
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index a4c539b..e46358f 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -639,7 +639,7 @@ static void ir_do_keyup(struct rc_dev *dev, bool sync)
 		return;
 
 	dev_dbg(&dev->dev, "keyup key 0x%04x\n", dev->last_keycode);
-	del_timer(&dev->timer_repeat);
+	timer_delete(&dev->timer_repeat);
 	input_report_key(dev->input_dev, dev->last_keycode, 0);
 	led_trigger_event(led_feedback, LED_OFF);
 	if (sync)
@@ -2021,8 +2021,8 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
-	del_timer_sync(&dev->timer_keyup);
-	del_timer_sync(&dev->timer_repeat);
+	timer_delete_sync(&dev->timer_keyup);
+	timer_delete_sync(&dev->timer_repeat);
 
 	mutex_lock(&dev->lock);
 	if (dev->users && dev->close)
diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index fc5fd39..992fff8 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	del_timer_sync(&serial_ir.timeout_timer);
+	timer_delete_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
diff --git a/drivers/media/usb/au0828/au0828-dvb.c b/drivers/media/usb/au0828/au0828-dvb.c
index 09f9948..3666f44 100644
--- a/drivers/media/usb/au0828/au0828-dvb.c
+++ b/drivers/media/usb/au0828/au0828-dvb.c
@@ -143,7 +143,7 @@ static void urb_completion(struct urb *purb)
 		 */
 		dprintk(1, "%s cancelling bulk timeout\n", __func__);
 		dev->bulk_timeout_running = 0;
-		del_timer(&dev->bulk_timeout);
+		timer_delete(&dev->bulk_timeout);
 	}
 
 	/* Feed the transport payload into the kernel demux */
@@ -168,7 +168,7 @@ static int stop_urb_transfer(struct au0828_dev *dev)
 
 	if (dev->bulk_timeout_running == 1) {
 		dev->bulk_timeout_running = 0;
-		del_timer(&dev->bulk_timeout);
+		timer_delete(&dev->bulk_timeout);
 	}
 
 	dev->urb_streaming = false;
diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index e9cd2a3..33d1fad 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -857,7 +857,7 @@ static void au0828_stop_streaming(struct vb2_queue *vq)
 	}
 
 	dev->vid_timeout_running = 0;
-	del_timer_sync(&dev->vid_timeout);
+	timer_delete_sync(&dev->vid_timeout);
 
 	spin_lock_irqsave(&dev->slock, flags);
 	if (dev->isoc_ctl.buf != NULL) {
@@ -905,7 +905,7 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
 	spin_unlock_irqrestore(&dev->slock, flags);
 
 	dev->vbi_timeout_running = 0;
-	del_timer_sync(&dev->vbi_timeout);
+	timer_delete_sync(&dev->vbi_timeout);
 }
 
 static const struct vb2_ops au0828_video_qops = {
@@ -1040,12 +1040,12 @@ static int au0828_v4l2_close(struct file *filp)
 	if (vdev->vfl_type == VFL_TYPE_VIDEO && dev->vid_timeout_running) {
 		/* Cancel timeout thread in case they didn't call streamoff */
 		dev->vid_timeout_running = 0;
-		del_timer_sync(&dev->vid_timeout);
+		timer_delete_sync(&dev->vid_timeout);
 	} else if (vdev->vfl_type == VFL_TYPE_VBI &&
 			dev->vbi_timeout_running) {
 		/* Cancel timeout thread in case they didn't call streamoff */
 		dev->vbi_timeout_running = 0;
-		del_timer_sync(&dev->vbi_timeout);
+		timer_delete_sync(&dev->vbi_timeout);
 	}
 
 	if (test_bit(DEV_DISCONNECTED, &dev->dev_state))
@@ -1694,9 +1694,9 @@ void au0828_v4l2_suspend(struct au0828_dev *dev)
 	}
 
 	if (dev->vid_timeout_running)
-		del_timer_sync(&dev->vid_timeout);
+		timer_delete_sync(&dev->vid_timeout);
 	if (dev->vbi_timeout_running)
-		del_timer_sync(&dev->vbi_timeout);
+		timer_delete_sync(&dev->vbi_timeout);
 }
 
 void au0828_v4l2_resume(struct au0828_dev *dev)
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-encoder.c b/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
index c810277..a5eabac 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
@@ -257,7 +257,7 @@ rdData[0]);
 			ret = -EBUSY;
 		}
 		if (ret) {
-			del_timer_sync(&hdw->encoder_run_timer);
+			timer_delete_sync(&hdw->encoder_run_timer);
 			hdw->state_encoder_ok = 0;
 			pvr2_trace(PVR2_TRACE_STBITS,
 				   "State bit %s <-- %s",
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 29cc207..9a583ee 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -1527,7 +1527,7 @@ int pvr2_upload_firmware2(struct pvr2_hdw *hdw)
 
 	/* Encoder is about to be reset so note that as far as we're
 	   concerned now, the encoder has never been run. */
-	del_timer_sync(&hdw->encoder_run_timer);
+	timer_delete_sync(&hdw->encoder_run_timer);
 	if (hdw->state_encoder_runok) {
 		hdw->state_encoder_runok = 0;
 		trace_stbit("state_encoder_runok",hdw->state_encoder_runok);
@@ -3724,7 +3724,7 @@ status);
 	hdw->cmd_debug_state = 5;
 
 	/* Stop timer */
-	del_timer_sync(&timer.timer);
+	timer_delete_sync(&timer.timer);
 
 	hdw->cmd_debug_state = 6;
 	status = 0;
@@ -4248,7 +4248,7 @@ static int state_eval_encoder_config(struct pvr2_hdw *hdw)
 		hdw->state_encoder_waitok = 0;
 		trace_stbit("state_encoder_waitok",hdw->state_encoder_waitok);
 		/* paranoia - solve race if timer just completed */
-		del_timer_sync(&hdw->encoder_wait_timer);
+		timer_delete_sync(&hdw->encoder_wait_timer);
 	} else {
 		if (!hdw->state_pathway_ok ||
 		    (hdw->pathway_state != PVR2_PATHWAY_ANALOG) ||
@@ -4261,7 +4261,7 @@ static int state_eval_encoder_config(struct pvr2_hdw *hdw)
 			   anything has happened that might have disturbed
 			   the encoder.  This should be a rare case. */
 			if (timer_pending(&hdw->encoder_wait_timer)) {
-				del_timer_sync(&hdw->encoder_wait_timer);
+				timer_delete_sync(&hdw->encoder_wait_timer);
 			}
 			if (hdw->state_encoder_waitok) {
 				/* Must clear the state - therefore we did
@@ -4399,7 +4399,7 @@ static int state_eval_encoder_run(struct pvr2_hdw *hdw)
 	if (hdw->state_encoder_run) {
 		if (!state_check_disable_encoder_run(hdw)) return 0;
 		if (hdw->state_encoder_ok) {
-			del_timer_sync(&hdw->encoder_run_timer);
+			timer_delete_sync(&hdw->encoder_run_timer);
 			if (pvr2_encoder_stop(hdw) < 0) return !0;
 		}
 		hdw->state_encoder_run = 0;
@@ -4479,11 +4479,11 @@ static int state_eval_decoder_run(struct pvr2_hdw *hdw)
 		hdw->state_decoder_quiescent = 0;
 		hdw->state_decoder_run = 0;
 		/* paranoia - solve race if timer(s) just completed */
-		del_timer_sync(&hdw->quiescent_timer);
+		timer_delete_sync(&hdw->quiescent_timer);
 		/* Kill the stabilization timer, in case we're killing the
 		   encoder before the previous stabilization interval has
 		   been properly timed. */
-		del_timer_sync(&hdw->decoder_stabilization_timer);
+		timer_delete_sync(&hdw->decoder_stabilization_timer);
 		hdw->state_decoder_ready = 0;
 	} else {
 		if (!hdw->state_decoder_quiescent) {
@@ -4517,7 +4517,7 @@ static int state_eval_decoder_run(struct pvr2_hdw *hdw)
 		    !hdw->state_pipeline_config ||
 		    !hdw->state_encoder_config ||
 		    !hdw->state_encoder_ok) return 0;
-		del_timer_sync(&hdw->quiescent_timer);
+		timer_delete_sync(&hdw->quiescent_timer);
 		if (hdw->flag_decoder_missed) return 0;
 		if (pvr2_decoder_enable(hdw,!0) < 0) return 0;
 		hdw->state_decoder_quiescent = 0;
diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index 2d5d824..e63f626 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -583,7 +583,7 @@ static void tegra210_emc_training_start(struct tegra210_emc *emc)
 
 static void tegra210_emc_training_stop(struct tegra210_emc *emc)
 {
-	del_timer(&emc->training);
+	timer_delete(&emc->training);
 }
 
 static unsigned int tegra210_emc_get_temperature(struct tegra210_emc *emc)
@@ -666,7 +666,7 @@ reset:
 static void tegra210_emc_poll_refresh_stop(struct tegra210_emc *emc)
 {
 	atomic_set(&emc->refresh_poll, 0);
-	del_timer_sync(&emc->refresh_timer);
+	timer_delete_sync(&emc->refresh_timer);
 }
 
 static void tegra210_emc_poll_refresh_start(struct tegra210_emc *emc)
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index f439838..7dc2c99 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1510,7 +1510,7 @@ static void msb_cache_discard(struct msb_data *msb)
 	if (msb->cache_block_lba == MS_BLOCK_INVALID)
 		return;
 
-	del_timer_sync(&msb->cache_flush_timer);
+	timer_delete_sync(&msb->cache_flush_timer);
 
 	dbg_verbose("Discarding the write cache");
 	msb->cache_block_lba = MS_BLOCK_INVALID;
@@ -2027,7 +2027,7 @@ static void msb_stop(struct memstick_dev *card)
 	msb->io_queue_stopped = true;
 	spin_unlock_irqrestore(&msb->q_lock, flags);
 
-	del_timer_sync(&msb->cache_flush_timer);
+	timer_delete_sync(&msb->cache_flush_timer);
 	flush_workqueue(msb->io_queue);
 
 	spin_lock_irqsave(&msb->q_lock, flags);
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index e77eb8b..a5a9bb3 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -469,7 +469,7 @@ static void jmb38x_ms_complete_cmd(struct memstick_host *msh, int last)
 	unsigned int t_val = 0;
 	int rc;
 
-	del_timer(&host->timer);
+	timer_delete(&host->timer);
 
 	dev_dbg(&msh->dev, "c control %08x\n",
 		readl(host->addr + HOST_CONTROL));
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 544a31f..488ef8e 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -827,7 +827,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-	del_timer_sync(&dev->detect_timer);
+	timer_delete_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
@@ -854,7 +854,7 @@ static int r592_suspend(struct device *core_dev)
 
 	r592_clear_interrupts(dev);
 	memstick_suspend_host(dev->host);
-	del_timer_sync(&dev->detect_timer);
+	timer_delete_sync(&dev->detect_timer);
 	return 0;
 }
 
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index c272453..676348e 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -337,7 +337,7 @@ static void tifm_ms_complete_cmd(struct tifm_ms *host)
 	struct memstick_host *msh = tifm_get_drvdata(sock);
 	int rc;
 
-	del_timer(&host->timer);
+	timer_delete(&host->timer);
 
 	host->req->int_reg = readl(sock->addr + SOCK_MS_STATUS) & 0xff;
 	host->req->int_reg = (host->req->int_reg & 1)
@@ -600,7 +600,7 @@ static void tifm_ms_remove(struct tifm_dev *sock)
 	spin_lock_irqsave(&sock->lock, flags);
 	host->eject = 1;
 	if (host->req) {
-		del_timer(&host->timer);
+		timer_delete(&host->timer);
 		writel(TIFM_FIFO_INT_SETALL,
 		       sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
 		writel(TIFM_DMA_RESET, sock->addr + SOCK_DMA_CONTROL);
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 59bab76..44a2dd8 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -177,7 +177,7 @@ static void bcm_vk_tty_close(struct tty_struct *tty, struct file *file)
 	vk->tty[tty->index].is_opened = false;
 
 	if (tty->count == 1)
-		del_timer_sync(&vk->serial_timer);
+		timer_delete_sync(&vk->serial_timer);
 }
 
 static void bcm_vk_tty_doorbell(struct bcm_vk *vk, u32 db_val)
@@ -304,7 +304,7 @@ void bcm_vk_tty_exit(struct bcm_vk *vk)
 {
 	int i;
 
-	del_timer_sync(&vk->serial_timer);
+	timer_delete_sync(&vk->serial_timer);
 	for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
 		tty_port_unregister_device(&vk->tty[i].port,
 					   vk->tty_drv,
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 77b0490..7314c8d 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -53,7 +53,7 @@ static int rtsx_usb_bulk_transfer_sglist(struct rtsx_ucr *ucr,
 	ucr->sg_timer.expires = jiffies + msecs_to_jiffies(timeout);
 	add_timer(&ucr->sg_timer);
 	usb_sg_wait(&ucr->current_sg);
-	if (!del_timer_sync(&ucr->sg_timer))
+	if (!timer_delete_sync(&ucr->sg_timer))
 		ret = -ETIMEDOUT;
 	else
 		ret = ucr->current_sg.status;
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 7a3c343..697a008 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -202,7 +202,7 @@ xpc_start_hb_beater(void)
 static void
 xpc_stop_hb_beater(void)
 {
-	del_timer_sync(&xpc_hb_timer);
+	timer_delete_sync(&xpc_hb_timer);
 	xpc_arch_ops.heartbeat_exit();
 }
 
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 1999d02..d046701 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -291,7 +291,7 @@ static int __xpc_partition_disengaged(struct xpc_partition *part,
 
 		/* Cancel the timer function if not called from it */
 		if (!from_timer)
-			del_timer_sync(&part->disengage_timer);
+			timer_delete_sync(&part->disengage_timer);
 
 		DBUG_ON(part->act_state != XPC_P_AS_DEACTIVATING &&
 			part->act_state != XPC_P_AS_INACTIVE);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index bdb2299..dacb5bd 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -147,13 +147,13 @@ void mmc_retune_disable(struct mmc_host *host)
 {
 	mmc_retune_unpause(host);
 	host->can_retune = 0;
-	del_timer_sync(&host->retune_timer);
+	timer_delete_sync(&host->retune_timer);
 	mmc_retune_clear(host);
 }
 
 void mmc_retune_timer_stop(struct mmc_host *host)
 {
-	del_timer_sync(&host->retune_timer);
+	timer_delete_sync(&host->retune_timer);
 }
 EXPORT_SYMBOL(mmc_retune_timer_stop);
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 24fffc7..14e981b 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1592,7 +1592,7 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 
 	WARN_ON(host->cmd || host->data);
 
-	del_timer(&host->timer);
+	timer_delete(&host->timer);
 
 	/*
 	 * Update the MMC clock rate if necessary. This may be
@@ -2357,7 +2357,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 	if (slot->detect_pin) {
 		free_irq(gpiod_to_irq(slot->detect_pin), slot);
-		del_timer_sync(&slot->detect_timer);
+		timer_delete_sync(&slot->detect_timer);
 	}
 
 	slot->host->slot[id] = NULL;
@@ -2585,7 +2585,7 @@ err_init_slot:
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
-	del_timer_sync(&host->timer);
+	timer_delete_sync(&host->timer);
 	if (!IS_ERR(host->dma.chan))
 		dma_release_channel(host->dma.chan);
 err_dma_probe_defer:
@@ -2613,7 +2613,7 @@ static void atmci_remove(struct platform_device *pdev)
 	atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
 	atmci_readl(host, ATMCI_SR);
 
-	del_timer_sync(&host->timer);
+	timer_delete_sync(&host->timer);
 	if (!IS_ERR(host->dma.chan))
 		dma_release_channel(host->dma.chan);
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bb596d1..5782900 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2040,10 +2040,10 @@ static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
 	 * Really be certain that the timer has stopped.  This is a bit of
 	 * paranoia and could only really happen if we had really bad
 	 * interrupt latency and the interrupt routine and timeout were
-	 * running concurrently so that the del_timer() in the interrupt
+	 * running concurrently so that the timer_delete() in the interrupt
 	 * handler couldn't run.
 	 */
-	WARN_ON(del_timer_sync(&host->cto_timer));
+	WARN_ON(timer_delete_sync(&host->cto_timer));
 	clear_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 
 	return true;
@@ -2055,7 +2055,7 @@ static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
 		return false;
 
 	/* Extra paranoia just like dw_mci_clear_pending_cmd_complete() */
-	WARN_ON(del_timer_sync(&host->dto_timer));
+	WARN_ON(timer_delete_sync(&host->dto_timer));
 	clear_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 
 	return true;
@@ -2788,7 +2788,7 @@ done:
 
 static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 {
-	del_timer(&host->cto_timer);
+	timer_delete(&host->cto_timer);
 
 	if (!host->cmd_status)
 		host->cmd_status = status;
@@ -2832,13 +2832,13 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_cmd_interrupt(host, pending);
 			spin_unlock(&host->irq_lock);
 
-			del_timer(&host->cmd11_timer);
+			timer_delete(&host->cmd11_timer);
 		}
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
 			spin_lock(&host->irq_lock);
 
-			del_timer(&host->cto_timer);
+			timer_delete(&host->cto_timer);
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
 			smp_wmb(); /* drain writebuffer */
@@ -2851,7 +2851,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			spin_lock(&host->irq_lock);
 
 			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
-				del_timer(&host->dto_timer);
+				timer_delete(&host->dto_timer);
 
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
@@ -2872,7 +2872,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & SDMMC_INT_DATA_OVER) {
 			spin_lock(&host->irq_lock);
 
-			del_timer(&host->dto_timer);
+			timer_delete(&host->dto_timer);
 
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
 			if (!host->data_status)
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 596012d..bd1662e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -862,7 +862,7 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 
 	if (host->req && cmd && irq_reg) {
 		if (test_and_clear_bit(0, &host->waiting)) {
-			del_timer(&host->timeout_timer);
+			timer_delete(&host->timeout_timer);
 
 			if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
 				cmd->error = -ETIMEDOUT;
@@ -1162,7 +1162,7 @@ static void jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
-	del_timer_sync(&host->timeout_timer);
+	timer_delete_sync(&host->timeout_timer);
 	jz4740_mmc_set_irq_enabled(host, 0xff, false);
 	jz4740_mmc_reset(host);
 
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index ad35180..e0ae5a0 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -446,7 +446,7 @@ static irqreturn_t meson_mx_mmc_irq_thread(int irq, void *irq_data)
 	if (WARN_ON(!cmd))
 		return IRQ_HANDLED;
 
-	del_timer_sync(&host->cmd_timeout);
+	timer_delete_sync(&host->cmd_timeout);
 
 	if (cmd->data) {
 		dma_unmap_sg(mmc_dev(host->mmc), cmd->data->sg,
@@ -733,7 +733,7 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
 	struct meson_mx_mmc_host *host = platform_get_drvdata(pdev);
 	struct device *slot_dev = mmc_dev(host->mmc);
 
-	del_timer_sync(&host->cmd_timeout);
+	timer_delete_sync(&host->cmd_timeout);
 
 	mmc_remove_host(host->mmc);
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index b92f3ba..912ffac 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -464,7 +464,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		struct mmc_command *cmd = mrq->cmd;
 		u32 err_status = 0;
 
-		del_timer(&host->timer);
+		timer_delete(&host->timer);
 		host->mrq = NULL;
 
 		host->intr_en &= MVSD_NOR_CARD_INT;
@@ -803,7 +803,7 @@ static void mvsd_remove(struct platform_device *pdev)
 	struct mvsd_host *host = mmc_priv(mmc);
 
 	mmc_remove_host(mmc);
-	del_timer_sync(&host->timer);
+	timer_delete_sync(&host->timer);
 	mvsd_power_down(host);
 
 	if (!IS_ERR(host->clk))
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 0a9affd..95d8d40 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -352,7 +352,7 @@ static void mxcmci_dma_callback(void *data)
 	struct mxcmci_host *host = data;
 	u32 stat;
 
-	del_timer(&host->watchdog);
+	timer_delete(&host->watchdog);
 
 	stat = mxcmci_readl(host, MMC_REG_STATUS);
 
@@ -737,7 +737,7 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 		mxcmci_cmd_done(host, stat);
 
 	if (mxcmci_use_dma(host) && (stat & STATUS_WRITE_OP_DONE)) {
-		del_timer(&host->watchdog);
+		timer_delete(&host->watchdog);
 		mxcmci_data_done(host, stat);
 	}
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 3cdb2fc..c50617d 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 	host->mmc = slot->mmc;
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 no_claim:
-	del_timer(&host->clk_timer);
+	timer_delete(&host->clk_timer);
 	if (host->current_slot != slot || !claimed)
 		mmc_omap_fclk_offdelay(host->current_slot);
 
@@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		/* Keeps clock running for at least 8 cycles on valid freq */
 		mod_timer(&host->clk_timer, jiffies  + HZ/10);
 	else {
-		del_timer(&host->clk_timer);
+		timer_delete(&host->clk_timer);
 		mmc_omap_fclk_offdelay(slot);
 		mmc_omap_fclk_enable(host, 0);
 	}
@@ -564,7 +564,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 {
 	host->cmd = NULL;
 
-	del_timer(&host->cmd_abort_timer);
+	timer_delete(&host->cmd_abort_timer);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
@@ -836,7 +836,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	}
 
 	if (cmd_error && host->data) {
-		del_timer(&host->cmd_abort_timer);
+		timer_delete(&host->cmd_abort_timer);
 		host->abort = 1;
 		OMAP_MMC_WRITE(host, IE, 0);
 		disable_irq_nosync(host->irq);
@@ -1365,7 +1365,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 		device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
 
 	cancel_work_sync(&slot->cover_bh_work);
-	del_timer_sync(&slot->cover_timer);
+	timer_delete_sync(&slot->cover_timer);
 	flush_workqueue(slot->host->mmc_omap_wq);
 
 	mmc_remove_host(mmc);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f91b44..5f78be7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -517,9 +517,9 @@ EXPORT_SYMBOL_GPL(sdhci_mod_timer);
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	if (sdhci_data_line_cmd(mrq->cmd))
-		del_timer(&host->data_timer);
+		timer_delete(&host->data_timer);
 	else
-		del_timer(&host->timer);
+		timer_delete(&host->timer);
 }
 
 static inline bool sdhci_has_requests(struct sdhci_host *host)
@@ -4976,8 +4976,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
 
-	del_timer_sync(&host->timer);
-	del_timer_sync(&host->data_timer);
+	timer_delete_sync(&host->timer);
+	timer_delete_sync(&host->data_timer);
 
 	destroy_workqueue(host->complete_wq);
 
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index aea14bf..713223f 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -735,7 +735,7 @@ static void tifm_sd_end_cmd(struct work_struct *t)
 
 	spin_lock_irqsave(&sock->lock, flags);
 
-	del_timer(&host->timer);
+	timer_delete(&host->timer);
 	mrq = host->req;
 	host->req = NULL;
 
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index f774571..909d80a 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -971,7 +971,7 @@ static void via_sdc_finish_bh_work(struct work_struct *t)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	del_timer(&host->timer);
+	timer_delete(&host->timer);
 	mrq = host->mrq;
 	host->mrq = NULL;
 	host->cmd = NULL;
@@ -1202,7 +1202,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
-	del_timer_sync(&sdhost->timer);
+	timer_delete_sync(&sdhost->timer);
 
 	cancel_work_sync(&sdhost->finish_bh_work);
 
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index fd67c06..dd71e5b 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1452,7 +1452,7 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 						  (linear_length / 16384));
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
-			del_timer(&vub300->sg_transfer_timer);
+			timer_delete(&vub300->sg_transfer_timer);
 			if (vub300->sg_request.status < 0) {
 				cmd->error = vub300->sg_request.status;
 				data->bytes_xfered = 0;
@@ -1572,7 +1572,7 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 			if (cmd->error) {
 				data->bytes_xfered = 0;
 			} else {
-				del_timer(&vub300->sg_transfer_timer);
+				timer_delete(&vub300->sg_transfer_timer);
 				if (vub300->sg_request.status < 0) {
 					cmd->error = vub300->sg_request.status;
 					data->bytes_xfered = 0;
@@ -2339,7 +2339,7 @@ static int vub300_probe(struct usb_interface *interface,
 
 	return 0;
 error6:
-	del_timer_sync(&vub300->inactivity_timer);
+	timer_delete_sync(&vub300->inactivity_timer);
 error5:
 	mmc_free_host(mmc);
 	/*
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 8b268e8..d5974b3 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1261,7 +1261,7 @@ static void wbsd_free_mmc(struct device *dev)
 	host = mmc_priv(mmc);
 	BUG_ON(host == NULL);
 
-	del_timer_sync(&host->ignore_timer);
+	timer_delete_sync(&host->ignore_timer);
 
 	mmc_free_host(mmc);
 }
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca..2199ba8 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -257,7 +257,7 @@ static int hdm_poison_channel(struct most_interface *iface, int channel)
 		mdev->padding_active[channel] = false;
 
 	if (mdev->conf[channel].data_type == MOST_CH_ASYNC) {
-		del_timer_sync(&mdev->link_stat_timer);
+		timer_delete_sync(&mdev->link_stat_timer);
 		cancel_work_sync(&mdev->poll_work_obj);
 	}
 	mutex_unlock(&mdev->io_mutex);
@@ -1115,7 +1115,7 @@ static void hdm_disconnect(struct usb_interface *interface)
 	mdev->usb_device = NULL;
 	mutex_unlock(&mdev->io_mutex);
 
-	del_timer_sync(&mdev->link_stat_timer);
+	timer_delete_sync(&mdev->link_stat_timer);
 	cancel_work_sync(&mdev->poll_work_obj);
 
 	if (mdev->dci)
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index b5b3c4c..d28d4f1 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -1067,7 +1067,7 @@ static int sm_write(struct mtd_blktrans_dev *dev,
 	sm_break_offset(ftl, sec_no << 9, &zone_num, &block, &boffset);
 
 	/* No need in flush thread running now */
-	del_timer(&ftl->timer);
+	timer_delete(&ftl->timer);
 	mutex_lock(&ftl->mutex);
 
 	zone = sm_get_zone(ftl, zone_num);
@@ -1111,7 +1111,7 @@ static void sm_release(struct mtd_blktrans_dev *dev)
 {
 	struct sm_ftl *ftl = dev->priv;
 
-	del_timer_sync(&ftl->timer);
+	timer_delete_sync(&ftl->timer);
 	cancel_work_sync(&ftl->flush_work);
 	mutex_lock(&ftl->mutex);
 	sm_cache_flush(ftl);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 530c15d..602e6e1 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -616,7 +616,7 @@ int arcnet_close(struct net_device *dev)
 	struct arcnet_local *lp = netdev_priv(dev);
 
 	arcnet_led_event(dev, ARCNET_LED_EVENT_STOP);
-	del_timer_sync(&lp->timer);
+	timer_delete_sync(&lp->timer);
 
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 21a61b8..adf3970 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -778,7 +778,7 @@ static irqreturn_t grcan_interrupt(int irq, void *dev_id)
 	 */
 	if (priv->need_txbug_workaround &&
 	    (sources & (GRCAN_IRQ_TX | GRCAN_IRQ_TXLOSS))) {
-		del_timer(&priv->hang_timer);
+		timer_delete(&priv->hang_timer);
 	}
 
 	/* Frame(s) received or transmitted */
@@ -817,8 +817,8 @@ static void grcan_running_reset(struct timer_list *t)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	priv->resetting = false;
-	del_timer(&priv->hang_timer);
-	del_timer(&priv->rr_timer);
+	timer_delete(&priv->hang_timer);
+	timer_delete(&priv->rr_timer);
 
 	if (!priv->closing) {
 		/* Save and reset - config register preserved by grcan_reset */
@@ -1108,8 +1108,8 @@ static int grcan_close(struct net_device *dev)
 	priv->closing = true;
 	if (priv->need_txbug_workaround) {
 		spin_unlock_irqrestore(&priv->lock, flags);
-		del_timer_sync(&priv->hang_timer);
-		del_timer_sync(&priv->rr_timer);
+		timer_delete_sync(&priv->hang_timer);
+		timer_delete_sync(&priv->rr_timer);
 		spin_lock_irqsave(&priv->lock, flags);
 	}
 	netif_stop_queue(dev);
@@ -1147,7 +1147,7 @@ static void grcan_transmit_catch_up(struct net_device *dev)
 		 * so prevent a running reset while catching up
 		 */
 		if (priv->need_txbug_workaround)
-			del_timer(&priv->hang_timer);
+			timer_delete(&priv->hang_timer);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa04a7c..cf0d518 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -631,7 +631,7 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	u32 mode;
 	unsigned long irq;
 
-	del_timer(&can->bec_poll_timer);
+	timer_delete(&can->bec_poll_timer);
 	if (!completion_done(&can->flush_comp))
 		kvaser_pciefd_start_controller_flush(can);
 
@@ -742,7 +742,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		ret = -ETIMEDOUT;
 	} else {
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-		del_timer(&can->bec_poll_timer);
+		timer_delete(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
 	close_candev(netdev);
@@ -1854,7 +1854,7 @@ static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
 		if (can) {
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
+			timer_delete(&can->bec_poll_timer);
 			kvaser_pciefd_pwm_stop(can);
 			free_candev(can->can.dev);
 		}
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index ebd5941..6c7b1c5 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -167,7 +167,7 @@ static void pcan_start_led_timer(struct pcan_pccard *card)
  */
 static void pcan_stop_led_timer(struct pcan_pccard *card)
 {
-	del_timer_sync(&card->led_timer);
+	timer_delete_sync(&card->led_timer);
 }
 
 /*
diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 8bb88b3..02709d1 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -206,7 +206,7 @@ static int mv88e6xxx_phy_ppu_access_get(struct mv88e6xxx_chip *chip)
 		}
 		chip->ppu_disabled = 1;
 	} else {
-		del_timer(&chip->ppu_timer);
+		timer_delete(&chip->ppu_timer);
 		ret = 0;
 	}
 
@@ -229,7 +229,7 @@ static void mv88e6xxx_phy_ppu_state_init(struct mv88e6xxx_chip *chip)
 
 static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
 {
-	del_timer_sync(&chip->ppu_timer);
+	timer_delete_sync(&chip->ppu_timer);
 }
 
 int mv88e6185_phy_ppu_read(struct mv88e6xxx_chip *chip, struct mii_bus *bus,
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 08b45fd..198e787 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -842,7 +842,7 @@ static int sja1105_extts_enable(struct sja1105_private *priv,
 	if (on)
 		sja1105_ptp_extts_setup_timer(&priv->ptp_data);
 	else
-		del_timer_sync(&priv->ptp_data.extts_timer);
+		timer_delete_sync(&priv->ptp_data.extts_timer);
 
 	return 0;
 }
@@ -939,7 +939,7 @@ void sja1105_ptp_clock_unregister(struct dsa_switch *ds)
 	if (IS_ERR_OR_NULL(ptp_data->clock))
 		return;
 
-	del_timer_sync(&ptp_data->extts_timer);
+	timer_delete_sync(&ptp_data->extts_timer);
 	ptp_cancel_worker_sync(ptp_data->clock);
 	skb_queue_purge(&ptp_data->skb_txtstamp_queue);
 	skb_queue_purge(&ptp_data->skb_rxtstamp_queue);
diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index 3c2efda..5889759 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -254,7 +254,7 @@ static int eql_close(struct net_device *dev)
 	 *	at the data structure it scans every so often...
 	 */
 
-	del_timer_sync(&eql->timer);
+	timer_delete_sync(&eql->timer);
 
 	eql_kill_slave_queue(&eql->queue);
 
diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index 4725a8c..8ba2ed8 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -1414,7 +1414,7 @@ static int corkscrew_close(struct net_device *dev)
 			dev->name, rx_nocopy, rx_copy, queued_packet);
 	}
 
-	del_timer_sync(&vp->timer);
+	timer_delete_sync(&vp->timer);
 
 	/* Turn off statistics ASAP.  We update lp->stats below. */
 	outw(StatsDisable, ioaddr + EL3_CMD);
diff --git a/drivers/net/ethernet/3com/3c574_cs.c b/drivers/net/ethernet/3com/3c574_cs.c
index dc3b7c9..b295d52 100644
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ b/drivers/net/ethernet/3com/3c574_cs.c
@@ -1140,7 +1140,7 @@ static int el3_close(struct net_device *dev)
 
 	link->open--;
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->media);
+	timer_delete_sync(&lp->media);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/3com/3c589_cs.c b/drivers/net/ethernet/3com/3c589_cs.c
index be58dac..ff331a3 100644
--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -946,7 +946,7 @@ static int el3_close(struct net_device *dev)
 
 	link->open--;
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->media);
+	timer_delete_sync(&lp->media);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 7902709..1a10f5d 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -2691,7 +2691,7 @@ vortex_down(struct net_device *dev, int final_down)
 	netdev_reset_queue(dev);
 	netif_stop_queue(dev);
 
-	del_timer_sync(&vp->timer);
+	timer_delete_sync(&vp->timer);
 
 	/* Turn off statistics ASAP.  We update dev->stats below. */
 	iowrite16(StatsDisable, ioaddr + EL3_CMD);
diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index fea489a..e5be504 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -504,7 +504,7 @@ static int axnet_close(struct net_device *dev)
     
     link->open--;
     netif_stop_queue(dev);
-    del_timer_sync(&info->watchdog);
+    timer_delete_sync(&info->watchdog);
 
     return 0;
 } /* axnet_close */
diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 780fb4a..a326f25 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -947,7 +947,7 @@ static int pcnet_close(struct net_device *dev)
 
     link->open--;
     netif_stop_queue(dev);
-    del_timer_sync(&info->watchdog);
+    timer_delete_sync(&info->watchdog);
 
     return 0;
 } /* pcnet_close */
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index b325e0c..b398ada 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -3639,7 +3639,7 @@ static int et131x_close(struct net_device *netdev)
 	free_irq(adapter->pdev->irq, netdev);
 
 	/* Stop the error timer */
-	return del_timer_sync(&adapter->error_timer);
+	return timer_delete_sync(&adapter->error_timer);
 }
 
 /* et131x_set_packet_filter - Configures the Rx Packet filtering */
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 70fa3ad..897720f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3245,7 +3245,7 @@ static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 
 	netif_carrier_off(netdev);
 
-	del_timer_sync(&adapter->timer_service);
+	timer_delete_sync(&adapter->timer_service);
 
 	dev_up = test_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 	adapter->dev_up_before_reset = dev_up;
@@ -4065,7 +4065,7 @@ err_free_msix:
 	ena_free_mgmnt_irq(adapter);
 	ena_disable_msix(adapter);
 err_worker_destroy:
-	del_timer(&adapter->timer_service);
+	timer_delete(&adapter->timer_service);
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
@@ -4104,7 +4104,7 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
-	del_timer_sync(&adapter->timer_service);
+	timer_delete_sync(&adapter->timer_service);
 	cancel_work_sync(&adapter->reset_task);
 
 	rtnl_lock(); /* lock released inside the below if-else block */
diff --git a/drivers/net/ethernet/amd/a2065.c b/drivers/net/ethernet/amd/a2065.c
index 1ca26a8..b923ad9 100644
--- a/drivers/net/ethernet/amd/a2065.c
+++ b/drivers/net/ethernet/amd/a2065.c
@@ -486,7 +486,7 @@ static int lance_close(struct net_device *dev)
 	volatile struct lance_regs *ll = lp->ll;
 
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->multicast_timer);
+	timer_delete_sync(&lp->multicast_timer);
 
 	/* Stop the card */
 	ll->rap = LE_CSR0;
diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index f64f96f..86522e8 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -1173,7 +1173,7 @@ static int amd8111e_close(struct net_device *dev)
 
 	/* Delete ipg timer */
 	if (lp->options & OPTION_DYN_IPG_ENABLE)
-		del_timer_sync(&lp->ipg_data.ipg_timer);
+		timer_delete_sync(&lp->ipg_data.ipg_timer);
 
 	spin_unlock_irq(&lp->lock);
 	free_irq(dev->irq, dev);
@@ -1598,7 +1598,7 @@ static int __maybe_unused amd8111e_suspend(struct device *dev_d)
 	/* stop chip */
 	spin_lock_irq(&lp->lock);
 	if (lp->options & OPTION_DYN_IPG_ENABLE)
-		del_timer_sync(&lp->ipg_data.ipg_timer);
+		timer_delete_sync(&lp->ipg_data.ipg_timer);
 	amd8111e_stop_chip(lp);
 	spin_unlock_irq(&lp->lock);
 
diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd/declance.c
index ec8df05..b072ca5 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -842,7 +842,7 @@ static int lance_close(struct net_device *dev)
 	volatile struct lance_regs *ll = lp->ll;
 
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->multicast_timer);
+	timer_delete_sync(&lp->multicast_timer);
 
 	/* Stop the card */
 	writereg(&ll->rap, LE_CSR0);
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index c6bd803..e5adafe 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -2630,7 +2630,7 @@ static int pcnet32_close(struct net_device *dev)
 	struct pcnet32_private *lp = netdev_priv(dev);
 	unsigned long flags;
 
-	del_timer_sync(&lp->watchdog_timer);
+	timer_delete_sync(&lp->watchdog_timer);
 
 	netif_stop_queue(dev);
 	napi_disable(&lp->napi);
diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index 0f98b92..3cd3185 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -963,7 +963,7 @@ static int lance_close(struct net_device *dev)
 	struct lance_private *lp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	del_timer_sync(&lp->multicast_timer);
+	timer_delete_sync(&lp->multicast_timer);
 
 	STOP_LANCE(lp);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 5475867..d84a310 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -728,7 +728,7 @@ static void xgbe_stop_timers(struct xgbe_prv_data *pdata)
 	struct xgbe_channel *channel;
 	unsigned int i;
 
-	del_timer_sync(&pdata->service_timer);
+	timer_delete_sync(&pdata->service_timer);
 
 	for (i = 0; i < pdata->channel_count; i++) {
 		channel = pdata->channel[i];
@@ -736,7 +736,7 @@ static void xgbe_stop_timers(struct xgbe_prv_data *pdata)
 			break;
 
 		/* Deactivate the Tx timer */
-		del_timer_sync(&channel->tx_timer);
+		timer_delete_sync(&channel->tx_timer);
 		channel->tx_timer_active = 0;
 	}
 }
diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 785f4b4..b9fdd61 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -461,7 +461,7 @@ static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
 	/* prolly should wait for dma to finish & turn off the chip */
 	spin_lock_irqsave(&bp->lock, flags);
 	if (bp->timeout_active) {
-		del_timer(&bp->tx_timeout);
+		timer_delete(&bp->tx_timeout);
 		bp->timeout_active = 0;
 	}
 	disable_irq(dev->irq);
@@ -546,7 +546,7 @@ static inline void bmac_set_timeout(struct net_device *dev)
 
 	spin_lock_irqsave(&bp->lock, flags);
 	if (bp->timeout_active)
-		del_timer(&bp->tx_timeout);
+		timer_delete(&bp->tx_timeout);
 	bp->tx_timeout.expires = jiffies + TX_TIMEOUT;
 	add_timer(&bp->tx_timeout);
 	bp->timeout_active = 1;
@@ -755,7 +755,7 @@ static irqreturn_t bmac_txdma_intr(int irq, void *dev_id)
 		XXDEBUG(("bmac_txdma_intr\n"));
 	}
 
-	/*     del_timer(&bp->tx_timeout); */
+	/*     timer_delete(&bp->tx_timeout); */
 	/*     bp->timeout_active = 0; */
 
 	while (1) {
diff --git a/drivers/net/ethernet/apple/mace.c b/drivers/net/ethernet/apple/mace.c
index e635097..1fed112 100644
--- a/drivers/net/ethernet/apple/mace.c
+++ b/drivers/net/ethernet/apple/mace.c
@@ -523,7 +523,7 @@ static inline void mace_set_timeout(struct net_device *dev)
     struct mace_data *mp = netdev_priv(dev);
 
     if (mp->timeout_active)
-	del_timer(&mp->tx_timeout);
+	timer_delete(&mp->tx_timeout);
     mp->tx_timeout.expires = jiffies + TX_TIMEOUT;
     add_timer(&mp->tx_timeout);
     mp->timeout_active = 1;
@@ -676,7 +676,7 @@ static irqreturn_t mace_interrupt(int irq, void *dev_id)
 
     i = mp->tx_empty;
     while (in_8(&mb->pr) & XMTSV) {
-	del_timer(&mp->tx_timeout);
+	timer_delete(&mp->tx_timeout);
 	mp->timeout_active = 0;
 	/*
 	 * Clear any interrupt indication associated with this status
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 71e50fc..bf3aa46 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1389,13 +1389,13 @@ int aq_nic_stop(struct aq_nic_s *self)
 	netif_tx_disable(self->ndev);
 	netif_carrier_off(self->ndev);
 
-	del_timer_sync(&self->service_timer);
+	timer_delete_sync(&self->service_timer);
 	cancel_work_sync(&self->service_task);
 
 	self->aq_hw_ops->hw_irq_disable(self->aq_hw, AQ_CFG_IRQ_MASK);
 
 	if (self->aq_nic_cfg.is_polling)
-		del_timer_sync(&self->polling_timer);
+		timer_delete_sync(&self->polling_timer);
 	else
 		aq_pci_func_free_irqs(self);
 
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 3d4c3d8..67b6548 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1391,7 +1391,7 @@ static void ag71xx_hw_disable(struct ag71xx *ag)
 	ag71xx_dma_reset(ag);
 
 	napi_disable(&ag->napi);
-	del_timer_sync(&ag->oom_timer);
+	timer_delete_sync(&ag->oom_timer);
 
 	ag71xx_rings_cleanup(ag);
 }
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index c571614..82137f9 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -357,7 +357,7 @@ static void atl1c_common_task(struct work_struct *work)
 
 static void atl1c_del_timer(struct atl1c_adapter *adapter)
 {
-	del_timer_sync(&adapter->phy_config_timer);
+	timer_delete_sync(&adapter->phy_config_timer);
 }
 
 
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 9b778b3..f664a0e 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -232,7 +232,7 @@ static void atl1e_link_chg_event(struct atl1e_adapter *adapter)
 
 static void atl1e_del_timer(struct atl1e_adapter *adapter)
 {
-	del_timer_sync(&adapter->phy_config_timer);
+	timer_delete_sync(&adapter->phy_config_timer);
 }
 
 static void atl1e_cancel_work(struct atl1e_adapter *adapter)
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 3afd362..38cd84b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2641,7 +2641,7 @@ static void atl1_down(struct atl1_adapter *adapter)
 
 	napi_disable(&adapter->napi);
 	netif_stop_queue(netdev);
-	del_timer_sync(&adapter->phy_config_timer);
+	timer_delete_sync(&adapter->phy_config_timer);
 	adapter->phy_timer_pending = false;
 
 	atlx_irq_disable(adapter);
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index fa9a491..88f65f8 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -752,8 +752,8 @@ static void atl2_down(struct atl2_adapter *adapter)
 
 	atl2_irq_disable(adapter);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_config_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_config_timer);
 	clear_bit(0, &adapter->cfg_phy);
 
 	netif_carrier_off(netdev);
@@ -1468,8 +1468,8 @@ static void atl2_remove(struct pci_dev *pdev)
 	 * explicitly disable watchdog tasks from being rescheduled  */
 	set_bit(__ATL2_DOWN, &adapter->flags);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_config_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_config_timer);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->link_chg_task);
 
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index e5809ad..c918843 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1628,7 +1628,7 @@ static int b44_close(struct net_device *dev)
 
 	napi_disable(&bp->napi);
 
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 
 	spin_lock_irq(&bp->lock);
 
@@ -2473,7 +2473,7 @@ static int b44_suspend(struct ssb_device *sdev, pm_message_t state)
 	if (!netif_running(dev))
 		return 0;
 
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 
 	spin_lock_irq(&bp->lock);
 
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 65e3a06..19611bd 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1195,7 +1195,7 @@ static int bcm_enet_stop(struct net_device *dev)
 	napi_disable(&priv->napi);
 	if (priv->has_phy)
 		phy_stop(dev->phydev);
-	del_timer_sync(&priv->rx_timeout);
+	timer_delete_sync(&priv->rx_timeout);
 
 	/* mask all interrupts */
 	enet_writel(priv, 0, ENET_IRMASK_REG);
@@ -2346,10 +2346,10 @@ static int bcm_enetsw_stop(struct net_device *dev)
 	priv = netdev_priv(dev);
 	kdev = &priv->pdev->dev;
 
-	del_timer_sync(&priv->swphy_poll);
+	timer_delete_sync(&priv->swphy_poll);
 	netif_stop_queue(dev);
 	napi_disable(&priv->napi);
-	del_timer_sync(&priv->rx_timeout);
+	timer_delete_sync(&priv->rx_timeout);
 
 	/* mask all interrupts */
 	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 6ec773e..ec0c958 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6400,7 +6400,7 @@ bnx2_open(struct net_device *dev)
 				rc = bnx2_request_irq(bp);
 
 			if (rc) {
-				del_timer_sync(&bp->timer);
+				timer_delete_sync(&bp->timer);
 				goto open_err;
 			}
 			bnx2_enable_int(bp);
@@ -6752,7 +6752,7 @@ bnx2_close(struct net_device *dev)
 	bnx2_disable_int_sync(bp);
 	bnx2_napi_disable(bp);
 	netif_tx_disable(dev);
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 	bnx2_shutdown_chip(bp);
 	bnx2_free_irq(bp);
 	bnx2_free_skbs(bp);
@@ -8602,7 +8602,7 @@ bnx2_remove_one(struct pci_dev *pdev)
 
 	unregister_netdev(dev);
 
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 	cancel_work_sync(&bp->reset_task);
 
 	pci_iounmap(bp->pdev, bp->regview);
@@ -8629,7 +8629,7 @@ bnx2_suspend(struct device *device)
 		cancel_work_sync(&bp->reset_task);
 		bnx2_netif_stop(bp, true);
 		netif_device_detach(dev);
-		del_timer_sync(&bp->timer);
+		timer_delete_sync(&bp->timer);
 		bnx2_shutdown_chip(bp);
 		__bnx2_free_irq(bp);
 		bnx2_free_skbs(bp);
@@ -8687,7 +8687,7 @@ static pci_ers_result_t bnx2_io_error_detected(struct pci_dev *pdev,
 
 	if (netif_running(dev)) {
 		bnx2_netif_stop(bp, true);
-		del_timer_sync(&bp->timer);
+		timer_delete_sync(&bp->timer);
 		bnx2_reset_nic(bp, BNX2_DRV_MSG_CODE_RESET);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index a8e07e5..e595303 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3059,7 +3059,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
 
 	bp->rx_mode = BNX2X_RX_MODE_NONE;
 
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 
 	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 6788296..f522ca8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14140,7 +14140,7 @@ static int bnx2x_eeh_nic_unload(struct bnx2x *bp)
 	bnx2x_tx_disable(bp);
 	netdev_reset_tc(bp->dev);
 
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 	cancel_delayed_work_sync(&bp->sp_task);
 	cancel_delayed_work_sync(&bp->period_task);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1a70605..dbec50c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12958,7 +12958,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 
 	bnxt_debug_dev_exit(bp);
 	bnxt_disable_napi(bp);
-	del_timer_sync(&bp->timer);
+	timer_delete_sync(&bp->timer);
 	bnxt_free_skbs(bp);
 
 	/* Save ring stats before shutdown */
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d9d675f..d1f541a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -11252,7 +11252,7 @@ static void tg3_timer_start(struct tg3 *tp)
 
 static void tg3_timer_stop(struct tg3 *tp)
 {
-	del_timer_sync(&tp->timer);
+	timer_delete_sync(&tp->timer);
 }
 
 /* Restart hardware after configuration changes, self-test, etc.
diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index 9c80ab0..92c7639 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -314,13 +314,13 @@ bfa_ioc_sm_getattr(struct bfa_ioc *ioc, enum ioc_event event)
 {
 	switch (event) {
 	case IOC_E_FWRSP_GETATTR:
-		del_timer(&ioc->ioc_timer);
+		timer_delete(&ioc->ioc_timer);
 		bfa_fsm_set_state(ioc, bfa_ioc_sm_op);
 		break;
 
 	case IOC_E_PFFAILED:
 	case IOC_E_HWERROR:
-		del_timer(&ioc->ioc_timer);
+		timer_delete(&ioc->ioc_timer);
 		fallthrough;
 	case IOC_E_TIMEOUT:
 		ioc->cbfn->enable_cbfn(ioc->bfa, BFA_STATUS_IOC_FAILURE);
@@ -330,7 +330,7 @@ bfa_ioc_sm_getattr(struct bfa_ioc *ioc, enum ioc_event event)
 		break;
 
 	case IOC_E_DISABLE:
-		del_timer(&ioc->ioc_timer);
+		timer_delete(&ioc->ioc_timer);
 		bfa_fsm_set_state(ioc, bfa_ioc_sm_disabling);
 		break;
 
@@ -659,13 +659,13 @@ bfa_iocpf_sm_mismatch(struct bfa_iocpf *iocpf, enum iocpf_event event)
 		break;
 
 	case IOCPF_E_DISABLE:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_reset);
 		bfa_ioc_pf_disabled(ioc);
 		break;
 
 	case IOCPF_E_STOP:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_reset);
 		break;
 
@@ -741,7 +741,7 @@ bfa_iocpf_sm_hwinit(struct bfa_iocpf *iocpf, enum iocpf_event event)
 		break;
 
 	case IOCPF_E_DISABLE:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_ioc_sync_leave(ioc);
 		bfa_nw_ioc_hw_sem_release(ioc);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_disabled);
@@ -774,13 +774,13 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf *iocpf, enum iocpf_event event)
 
 	switch (event) {
 	case IOCPF_E_FWRSP_ENABLE:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_nw_ioc_hw_sem_release(ioc);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_ready);
 		break;
 
 	case IOCPF_E_INITFAIL:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		fallthrough;
 
 	case IOCPF_E_TIMEOUT:
@@ -791,7 +791,7 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf *iocpf, enum iocpf_event event)
 		break;
 
 	case IOCPF_E_DISABLE:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_nw_ioc_hw_sem_release(ioc);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_disabling);
 		break;
@@ -844,12 +844,12 @@ bfa_iocpf_sm_disabling(struct bfa_iocpf *iocpf, enum iocpf_event event)
 
 	switch (event) {
 	case IOCPF_E_FWRSP_DISABLE:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_disabling_sync);
 		break;
 
 	case IOCPF_E_FAIL:
-		del_timer(&ioc->iocpf_timer);
+		timer_delete(&ioc->iocpf_timer);
 		fallthrough;
 
 	case IOCPF_E_TIMEOUT:
@@ -1210,7 +1210,7 @@ bfa_nw_ioc_hw_sem_release(struct bfa_ioc *ioc)
 static void
 bfa_ioc_hw_sem_get_cancel(struct bfa_ioc *ioc)
 {
-	del_timer(&ioc->sem_timer);
+	timer_delete(&ioc->sem_timer);
 }
 
 /* Initialize LPU local memory (aka secondary memory / SRAM) */
@@ -1982,7 +1982,7 @@ bfa_ioc_hb_monitor(struct bfa_ioc *ioc)
 static void
 bfa_ioc_hb_stop(struct bfa_ioc *ioc)
 {
-	del_timer(&ioc->hb_timer);
+	timer_delete(&ioc->hb_timer);
 }
 
 /* Initiate a full firmware download. */
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 3b91070..a03eff3 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1837,7 +1837,7 @@ bnad_stats_timer_stop(struct bnad *bnad)
 		to_del = 1;
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
 	if (to_del)
-		del_timer_sync(&bnad->stats_timer);
+		timer_delete_sync(&bnad->stats_timer);
 }
 
 /* Utilities */
@@ -2160,7 +2160,7 @@ bnad_destroy_rx(struct bnad *bnad, u32 rx_id)
 		}
 		spin_unlock_irqrestore(&bnad->bna_lock, flags);
 		if (to_del)
-			del_timer_sync(&bnad->dim_timer);
+			timer_delete_sync(&bnad->dim_timer);
 	}
 
 	init_completion(&bnad->bnad_completions.rx_comp);
@@ -3726,9 +3726,9 @@ probe_uninit:
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3769,9 +3769,9 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_delete_sync(&bnad->bna.ioceth.ioc.hb_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index d1ad6c9..216e25f 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -373,7 +373,7 @@ static int bnad_set_coalesce(struct net_device *netdev,
 			}
 			spin_unlock_irqrestore(&bnad->bna_lock, flags);
 			if (to_del)
-				del_timer_sync(&bnad->dim_timer);
+				timer_delete_sync(&bnad->dim_timer);
 			spin_lock_irqsave(&bnad->bna_lock, flags);
 			bnad_rx_coalescing_timeo_set(bnad);
 		}
diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index 861edff..a10923c 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -1984,9 +1984,9 @@ void t1_sge_stop(struct sge *sge)
 	readl(sge->adapter->regs + A_SG_CONTROL); /* flush */
 
 	if (is_T2(sge->adapter))
-		del_timer_sync(&sge->espibug_timer);
+		timer_delete_sync(&sge->espibug_timer);
 
-	del_timer_sync(&sge->tx_reclaim_timer);
+	timer_delete_sync(&sge->tx_reclaim_timer);
 	if (sge->tx_sched)
 		tx_sched_stop(sge);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 6268f96..bd5c3b3 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -3223,9 +3223,9 @@ void t3_stop_sge_timers(struct adapter *adap)
 		struct sge_qset *q = &adap->sge.qs[i];
 
 		if (q->tx_reclaim_timer.function)
-			del_timer_sync(&q->tx_reclaim_timer);
+			timer_delete_sync(&q->tx_reclaim_timer);
 		if (q->rx_reclaim_timer.function)
-			del_timer_sync(&q->rx_reclaim_timer);
+			timer_delete_sync(&q->rx_reclaim_timer);
 	}
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index a7d76a8..f991a28 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4996,9 +4996,9 @@ void t4_sge_stop(struct adapter *adap)
 	struct sge *s = &adap->sge;
 
 	if (s->rx_timer.function)
-		del_timer_sync(&s->rx_timer);
+		timer_delete_sync(&s->rx_timer);
 	if (s->tx_timer.function)
-		del_timer_sync(&s->tx_timer);
+		timer_delete_sync(&s->tx_timer);
 
 	if (is_offload(adap)) {
 		struct sge_uld_txq_info *txq_info;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index 5b1d746..f42af01 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2609,9 +2609,9 @@ void t4vf_sge_stop(struct adapter *adapter)
 	struct sge *s = &adapter->sge;
 
 	if (s->rx_timer.function)
-		del_timer_sync(&s->rx_timer);
+		timer_delete_sync(&s->rx_timer);
 	if (s->tx_timer.function)
-		del_timer_sync(&s->tx_timer);
+		timer_delete_sync(&s->tx_timer);
 }
 
 /**
diff --git a/drivers/net/ethernet/cisco/enic/enic_clsf.h b/drivers/net/ethernet/cisco/enic/enic_clsf.h
index 8c4ce50..5f52841 100644
--- a/drivers/net/ethernet/cisco/enic/enic_clsf.h
+++ b/drivers/net/ethernet/cisco/enic/enic_clsf.h
@@ -26,7 +26,7 @@ static inline void enic_rfs_timer_start(struct enic *enic)
 
 static inline void enic_rfs_timer_stop(struct enic *enic)
 {
-	del_timer_sync(&enic->rfs_h.rfs_may_expire);
+	timer_delete_sync(&enic->rfs_h.rfs_may_expire);
 }
 #else
 static inline void enic_rfs_timer_start(struct enic *enic) {}
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 54aa395..c753c35 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1787,7 +1787,7 @@ static int enic_stop(struct net_device *netdev)
 
 	enic_synchronize_irqs(enic);
 
-	del_timer_sync(&enic->notify_timer);
+	timer_delete_sync(&enic->notify_timer);
 	enic_rfs_flw_tbl_free(enic);
 
 	enic_dev_disable(enic);
diff --git a/drivers/net/ethernet/dec/tulip/21142.c b/drivers/net/ethernet/dec/tulip/21142.c
index 3698582..76767de 100644
--- a/drivers/net/ethernet/dec/tulip/21142.c
+++ b/drivers/net/ethernet/dec/tulip/21142.c
@@ -216,7 +216,7 @@ void t21142_lnk_change(struct net_device *dev, int csr5)
 		    (csr12 & 2) == 2) ||
 		   (tp->nway && (csr5 & (TPLnkFail)))) {
 		/* Link blew? Maybe restart NWay. */
-		del_timer_sync(&tp->timer);
+		timer_delete_sync(&tp->timer);
 		t21142_start_nway(dev);
 		tp->timer.expires = RUN_AT(3*HZ);
 		add_timer(&tp->timer);
@@ -226,7 +226,7 @@ void t21142_lnk_change(struct net_device *dev, int csr5)
 				 medianame[dev->if_port],
 				 (csr12 & 2) ? "failed" : "good");
 		if ((csr12 & 2)  &&  ! tp->medialock) {
-			del_timer_sync(&tp->timer);
+			timer_delete_sync(&tp->timer);
 			t21142_start_nway(dev);
 			tp->timer.expires = RUN_AT(3*HZ);
 			add_timer(&tp->timer);
diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index 0a161a4..f9339d0 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -1428,7 +1428,7 @@ static int de_close (struct net_device *dev)
 
 	netif_dbg(de, ifdown, dev, "disabling interface\n");
 
-	del_timer_sync(&de->media_timer);
+	timer_delete_sync(&de->media_timer);
 
 	spin_lock_irqsave(&de->lock, flags);
 	de_stop_hw(de);
@@ -1452,7 +1452,7 @@ static void de_tx_timeout (struct net_device *dev, unsigned int txqueue)
 		   dr32(MacStatus), dr32(MacMode), dr32(SIAStatus),
 		   de->rx_tail, de->tx_head, de->tx_tail);
 
-	del_timer_sync(&de->media_timer);
+	timer_delete_sync(&de->media_timer);
 
 	disable_irq(irq);
 	spin_lock_irq(&de->lock);
@@ -2126,7 +2126,7 @@ static int __maybe_unused de_suspend(struct device *dev_d)
 	if (netif_running (dev)) {
 		const int irq = pdev->irq;
 
-		del_timer_sync(&de->media_timer);
+		timer_delete_sync(&de->media_timer);
 
 		disable_irq(irq);
 		spin_lock_irq(&de->lock);
diff --git a/drivers/net/ethernet/dec/tulip/dmfe.c b/drivers/net/ethernet/dec/tulip/dmfe.c
index 3188ba7..ae34b95 100644
--- a/drivers/net/ethernet/dec/tulip/dmfe.c
+++ b/drivers/net/ethernet/dec/tulip/dmfe.c
@@ -745,7 +745,7 @@ static int dmfe_stop(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	/* deleted timer */
-	del_timer_sync(&db->timer);
+	timer_delete_sync(&db->timer);
 
 	/* Reset & stop DM910X board */
 	dw32(DCR0, DM910X_RESET);
diff --git a/drivers/net/ethernet/dec/tulip/interrupt.c b/drivers/net/ethernet/dec/tulip/interrupt.c
index 54560f9..2d926a2 100644
--- a/drivers/net/ethernet/dec/tulip/interrupt.c
+++ b/drivers/net/ethernet/dec/tulip/interrupt.c
@@ -699,8 +699,8 @@ irqreturn_t tulip_interrupt(int irq, void *dev_instance)
 				tulip_start_rxtx(tp);
 			}
 			/*
-			 * NB: t21142_lnk_change() does a del_timer_sync(), so be careful if this
-			 * call is ever done under the spinlock
+			 * NB: t21142_lnk_change() does a timer_delete_sync(), so be careful
+			 * if this call is ever done under the spinlock
 			 */
 			if (csr5 & (TPLnkPass | TPLnkFail | 0x08000000)) {
 				if (tp->link_change)
diff --git a/drivers/net/ethernet/dec/tulip/pnic2.c b/drivers/net/ethernet/dec/tulip/pnic2.c
index 72a0915..2e3bdc0 100644
--- a/drivers/net/ethernet/dec/tulip/pnic2.c
+++ b/drivers/net/ethernet/dec/tulip/pnic2.c
@@ -323,7 +323,7 @@ void pnic2_lnk_change(struct net_device *dev, int csr5)
 		if (tulip_debug > 2)
 			netdev_dbg(dev, "Ugh! Link blew?\n");
 
-		del_timer_sync(&tp->timer);
+		timer_delete_sync(&tp->timer);
 		pnic2_start_nway(dev);
 		tp->timer.expires = RUN_AT(3*HZ);
 		add_timer(&tp->timer);
@@ -348,7 +348,7 @@ void pnic2_lnk_change(struct net_device *dev, int csr5)
 
                 /* if failed then try doing an nway to get in sync */
 		if ((csr12 & 2)  &&  ! tp->medialock) {
-			del_timer_sync(&tp->timer);
+			timer_delete_sync(&tp->timer);
 			pnic2_start_nway(dev);
 			tp->timer.expires = RUN_AT(3*HZ);
 			add_timer(&tp->timer);
@@ -372,7 +372,7 @@ void pnic2_lnk_change(struct net_device *dev, int csr5)
 
                 /* if failed, try doing an nway to get in sync */
 		if ((csr12 & 4)  &&  ! tp->medialock) {
-			del_timer_sync(&tp->timer);
+			timer_delete_sync(&tp->timer);
 			pnic2_start_nway(dev);
 			tp->timer.expires = RUN_AT(3*HZ);
 			add_timer(&tp->timer);
diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index 75eac18..c8c5312 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -747,9 +747,9 @@ static void tulip_down (struct net_device *dev)
 	napi_disable(&tp->napi);
 #endif
 
-	del_timer_sync (&tp->timer);
+	timer_delete_sync(&tp->timer);
 #ifdef CONFIG_TULIP_NAPI
-	del_timer_sync (&tp->oom_timer);
+	timer_delete_sync(&tp->oom_timer);
 #endif
 	spin_lock_irqsave (&tp->lock, flags);
 
diff --git a/drivers/net/ethernet/dec/tulip/uli526x.c b/drivers/net/ethernet/dec/tulip/uli526x.c
index ff080ab..3f1bd67 100644
--- a/drivers/net/ethernet/dec/tulip/uli526x.c
+++ b/drivers/net/ethernet/dec/tulip/uli526x.c
@@ -656,7 +656,7 @@ static int uli526x_stop(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	/* deleted timer */
-	del_timer_sync(&db->timer);
+	timer_delete_sync(&db->timer);
 
 	/* Reset & stop ULI526X board */
 	uw32(DCR0, ULI526X_RESET);
diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index 37fba39..5930cde 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -1509,7 +1509,7 @@ static int netdev_close(struct net_device *dev)
 	}
 #endif /* __i386__ debugging only */
 
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 
 	free_rxtx_rings(np);
 	free_ringdesc(np);
@@ -1560,7 +1560,7 @@ static int __maybe_unused w840_suspend(struct device *dev_d)
 
 	rtnl_lock();
 	if (netif_running (dev)) {
-		del_timer_sync(&np->timer);
+		timer_delete_sync(&np->timer);
 
 		spin_lock_irq(&np->lock);
 		netif_device_detach(dev);
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea926..d88fbec 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1778,7 +1778,7 @@ rio_close (struct net_device *dev)
 	rio_hw_stop(dev);
 
 	free_irq(pdev->irq, dev);
-	del_timer_sync (&np->timer);
+	timer_delete_sync(&np->timer);
 
 	free_list(dev);
 
@@ -1818,7 +1818,7 @@ static int rio_suspend(struct device *device)
 		return 0;
 
 	netif_device_detach(dev);
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 	rio_hw_stop(dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index ed18450..670b682 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -1900,8 +1900,8 @@ static int netdev_close(struct net_device *dev)
 	/* Stop the chip's Tx and Rx processes. */
 	stop_nic_rxtx(ioaddr, 0);
 
-	del_timer_sync(&np->timer);
-	del_timer_sync(&np->reset_timer);
+	timer_delete_sync(&np->timer);
+	timer_delete_sync(&np->reset_timer);
 
 	free_irq(np->pci_dev->irq, dev);
 
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 31a21cc..737f2ed 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -703,7 +703,7 @@ static int gve_set_priv_flags(struct net_device *netdev, u32 flags)
 
 		memset(priv->stats_report->stats, 0, (tx_stats_num + rx_stats_num) *
 				   sizeof(struct stats));
-		del_timer_sync(&priv->stats_report_timer);
+		timer_delete_sync(&priv->stats_report_timer);
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f9a73c9..c3791cf 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -302,7 +302,7 @@ static void gve_free_stats_report(struct gve_priv *priv)
 	if (!priv->stats_report)
 		return;
 
-	del_timer_sync(&priv->stats_report_timer);
+	timer_delete_sync(&priv->stats_report_timer);
 	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
 			  priv->stats_report, priv->stats_report_bus);
 	priv->stats_report = NULL;
@@ -1408,7 +1408,7 @@ static int gve_queues_stop(struct gve_priv *priv)
 			goto err;
 		gve_clear_device_rings_ok(priv);
 	}
-	del_timer_sync(&priv->stats_report_timer);
+	timer_delete_sync(&priv->stats_report_timer);
 
 	gve_unreg_xdp_info(priv);
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 42bb341..d98f8d3 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1402,7 +1402,7 @@ static void hns_nic_net_down(struct net_device *ndev)
 	if (test_and_set_bit(NIC_STATE_DOWN, &priv->state))
 		return;
 
-	(void)del_timer_sync(&priv->service_timer);
+	(void) timer_delete_sync(&priv->service_timer);
 	netif_tx_stop_all_queues(ndev);
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 92f9b8e..3e28a08 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11492,7 +11492,7 @@ static void hclge_state_uninit(struct hclge_dev *hdev)
 	set_bit(HCLGE_STATE_REMOVING, &hdev->state);
 
 	if (hdev->reset_timer.function)
-		del_timer_sync(&hdev->reset_timer);
+		timer_delete_sync(&hdev->reset_timer);
 	if (hdev->service_task.work.func)
 		cancel_delayed_work_sync(&hdev->service_task);
 }
diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 3a5bbda..c0ead54 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2293,7 +2293,7 @@ static int e100_up(struct nic *nic)
 	return 0;
 
 err_no_irq:
-	del_timer_sync(&nic->watchdog);
+	timer_delete_sync(&nic->watchdog);
 err_clean_cbs:
 	e100_clean_cbs(nic);
 err_rx_clean_list:
@@ -2308,7 +2308,7 @@ static void e100_down(struct nic *nic)
 	netif_stop_queue(nic->netdev);
 	e100_hw_reset(nic);
 	free_irq(nic->pdev->irq, nic->netdev);
-	del_timer_sync(&nic->watchdog);
+	timer_delete_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
 	e100_clean_cbs(nic);
 	e100_rx_clean_list(nic);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 286155e..8ebcb6a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4287,8 +4287,8 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 
 	napi_synchronize(&adapter->napi);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	spin_lock(&adapter->stats64_lock);
 	e1000e_update_stats(adapter);
@@ -7741,8 +7741,8 @@ static void e1000_remove(struct pci_dev *pdev)
 	 * from being rescheduled.
 	 */
 	set_bit(__E1000_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 92de609..21267ab 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
 
-	del_timer_sync(&interface->service_timer);
+	timer_delete_sync(&interface->service_timer);
 
 	fm10k_stop_service_event(interface);
 	fm10k_stop_macvlan_task(interface);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 65a7026..120d686 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16382,7 +16382,7 @@ static int i40e_io_suspend(struct i40e_pf *pf)
 	set_bit(__I40E_DOWN, pf->state);
 
 	/* Ensure service task will not be running */
-	del_timer_sync(&pf->service_timer);
+	timer_delete_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
 
 	/* Client close must be called explicitly here because the timer
@@ -16581,7 +16581,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
 
-	del_timer_sync(&pf->service_timer);
+	timer_delete_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
 	i40e_cloud_filter_exit(pf);
 	i40e_fdir_teardown(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 049edeb..d390157 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1717,7 +1717,7 @@ static int ice_service_task_stop(struct ice_pf *pf)
 	ret = test_and_set_bit(ICE_SERVICE_DIS, pf->state);
 
 	if (pf->serv_tmr.function)
-		del_timer_sync(&pf->serv_tmr);
+		timer_delete_sync(&pf->serv_tmr);
 	if (pf->serv_task.func)
 		cancel_work_sync(&pf->serv_task);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 9be4bd7..7752920 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -1521,7 +1521,7 @@ ice_vc_fdir_irq_handler(struct ice_vsi *ctrl_vsi,
 	memcpy(&ctx_done->rx_desc, rx_desc, sizeof(*rx_desc));
 	spin_unlock_irqrestore(&fdir->ctx_lock, flags);
 
-	ret = del_timer(&ctx_irq->rx_tmr);
+	ret = timer_delete(&ctx_irq->rx_tmr);
 	if (!ret)
 		dev_err(dev, "VF %d: Unexpected inactive timer!\n", vf->vf_id);
 
@@ -1916,7 +1916,7 @@ static void ice_vc_fdir_clear_irq_ctx(struct ice_vf *vf)
 	struct ice_vf_fdir_ctx *ctx = &vf->fdir.ctx_irq;
 	unsigned long flags;
 
-	del_timer(&ctx->rx_tmr);
+	timer_delete(&ctx->rx_tmr);
 	spin_lock_irqsave(&vf->fdir.ctx_lock, flags);
 	ctx->flags &= ~ICE_VF_FDIR_CTX_VALID;
 	spin_unlock_irqrestore(&vf->fdir.ctx_lock, flags);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d368b75..c646c71 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2185,8 +2185,8 @@ void igb_down(struct igb_adapter *adapter)
 		}
 	}
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
@@ -3860,8 +3860,8 @@ static void igb_remove(struct pci_dev *pdev)
 	 * disable watchdog from being rescheduled.
 	 */
 	set_bit(__IGB_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 02044aa..beb0124 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1592,7 +1592,7 @@ void igbvf_down(struct igbvf_adapter *adapter)
 
 	igbvf_irq_disable(adapter);
 
-	del_timer_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
 
 	/* record the stats before reset*/
 	igbvf_update_stats(adapter);
@@ -2912,7 +2912,7 @@ static void igbvf_remove(struct pci_dev *pdev)
 	 * disable it from being rescheduled.
 	 */
 	set_bit(__IGBVF_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 491d942..7997ef1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5291,8 +5291,8 @@ void igc_down(struct igc_adapter *adapter)
 		}
 	}
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
@@ -7272,8 +7272,8 @@ static void igc_remove(struct pci_dev *pdev)
 
 	set_bit(__IGC_DOWN, &adapter->state);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 481f917..a271821 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6538,7 +6538,7 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 	adapter->flags2 &= ~IXGBE_FLAG2_FDIR_REQUIRES_REINIT;
 	adapter->flags &= ~IXGBE_FLAG_NEED_LINK_UPDATE;
 
-	del_timer_sync(&adapter->service_timer);
+	timer_delete_sync(&adapter->service_timer);
 
 	if (adapter->num_vfs) {
 		/* Clear EITR Select mapping */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 6442f11..a217c5c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2514,7 +2514,7 @@ void ixgbevf_down(struct ixgbevf_adapter *adapter)
 
 	ixgbevf_napi_disable_all(adapter);
 
-	del_timer_sync(&adapter->service_timer);
+	timer_delete_sync(&adapter->service_timer);
 
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < adapter->num_tx_queues; i++) {
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 87c7e62..1e2ac1a 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1239,7 +1239,7 @@ static int korina_close(struct net_device *dev)
 	struct korina_private *lp = netdev_priv(dev);
 	u32 tmp;
 
-	del_timer(&lp->media_check_timer);
+	timer_delete(&lp->media_check_timer);
 
 	/* Disable interrupts */
 	disable_irq(lp->rx_irq);
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 67a6ff0..8cc888b 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2247,7 +2247,7 @@ static int mv643xx_eth_poll(struct napi_struct *napi, int budget)
 
 	if (unlikely(mp->oom)) {
 		mp->oom = 0;
-		del_timer(&mp->rx_oom);
+		timer_delete(&mp->rx_oom);
 	}
 
 	work_done = 0;
@@ -2521,7 +2521,7 @@ static int mv643xx_eth_stop(struct net_device *dev)
 
 	napi_disable(&mp->napi);
 
-	del_timer_sync(&mp->rx_oom);
+	timer_delete_sync(&mp->rx_oom);
 
 	netif_carrier_off(dev);
 	if (dev->phydev)
@@ -2531,7 +2531,7 @@ static int mv643xx_eth_stop(struct net_device *dev)
 	port_reset(mp);
 	mv643xx_eth_get_stats(dev);
 	mib_counters_update(mp);
-	del_timer_sync(&mp->mib_counters_timer);
+	timer_delete_sync(&mp->mib_counters_timer);
 
 	for (i = 0; i < mp->rxq_count; i++)
 		rxq_deinit(mp->rxq + i);
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 2bf426c..72c1967 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1175,7 +1175,7 @@ static int pxa168_eth_stop(struct net_device *dev)
 	/* Write to ICR to clear interrupts. */
 	wrl(pep, INT_W_CLEAR, 0);
 	napi_disable(&pep->napi);
-	del_timer_sync(&pep->timeout);
+	timer_delete_sync(&pep->timeout);
 	netif_carrier_off(dev);
 	free_irq(dev->irq, dev);
 	rxq_deinit(dev);
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index a1bada9..b2081d6 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -2662,7 +2662,7 @@ static int skge_down(struct net_device *dev)
 	netif_tx_disable(dev);
 
 	if (is_genesis(hw) && hw->phy_type == SK_PHY_XMAC)
-		del_timer_sync(&skge->link_timer);
+		timer_delete_sync(&skge->link_timer);
 
 	napi_disable(&skge->napi);
 	netif_carrier_off(dev);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index d7121c8..e2a9aae 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5052,7 +5052,7 @@ static int sky2_suspend(struct device *dev)
 	if (!hw)
 		return 0;
 
-	del_timer_sync(&hw->watchdog_timer);
+	timer_delete_sync(&hw->watchdog_timer);
 	cancel_work_sync(&hw->restart_work);
 
 	rtnl_lock();
diff --git a/drivers/net/ethernet/mellanox/mlx4/catas.c b/drivers/net/ethernet/mellanox/mlx4/catas.c
index 0d8a362..33ba0a5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/catas.c
+++ b/drivers/net/ethernet/mellanox/mlx4/catas.c
@@ -305,7 +305,7 @@ void mlx4_stop_catas_poll(struct mlx4_dev *dev)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 
-	del_timer_sync(&priv->catas_err.timer);
+	timer_delete_sync(&priv->catas_err.timer);
 
 	if (priv->catas_err.map) {
 		iounmap(priv->catas_err.map);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 6830a49..5442a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -246,7 +246,7 @@ static void mlx5_stop_sync_reset_poll(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
-	del_timer_sync(&fw_reset->timer);
+	timer_delete_sync(&fw_reset->timer);
 }
 
 static int mlx5_sync_reset_clear_reset_requested(struct mlx5_core_dev *dev, bool poll_health)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 91613d5..624452d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -847,7 +847,7 @@ void mlx5_stop_health_poll(struct mlx5_core_dev *dev, bool disable_health)
 	if (disable_health)
 		set_bit(MLX5_DROP_HEALTH_WORK, &health->flags);
 
-	del_timer_sync(&health->timer);
+	timer_delete_sync(&health->timer);
 }
 
 void mlx5_start_health_fw_log_up(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index dc1d9f7..1302aa8 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -3951,7 +3951,7 @@ static void ksz_stop_timer(struct ksz_timer_info *info)
 {
 	if (info->max) {
 		info->max = 0;
-		del_timer_sync(&info->timer);
+		timer_delete_sync(&info->timer);
 	}
 }
 
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index b7d9657..7c501a7 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -2482,7 +2482,7 @@ static int myri10ge_close(struct net_device *dev)
 	if (mgp->ss[0].tx.req_bytes == NULL)
 		return 0;
 
-	del_timer_sync(&mgp->watchdog_timer);
+	timer_delete_sync(&mgp->watchdog_timer);
 	mgp->running = MYRI10GE_ETH_STOPPING;
 	for (i = 0; i < mgp->num_slices; i++)
 		napi_disable(&mgp->ss[i].napi);
diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index ad0c148..0560669 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -3179,7 +3179,7 @@ static int netdev_close(struct net_device *dev)
 	 * the final WOL settings?
 	 */
 
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 	disable_irq(irq);
 	spin_lock_irq(&np->lock);
 	natsemi_irq_disable(dev);
@@ -3278,7 +3278,7 @@ static int __maybe_unused natsemi_suspend(struct device *dev_d)
 	if (netif_running (dev)) {
 		const int irq = np->pci_dev->irq;
 
-		del_timer_sync(&np->timer);
+		timer_delete_sync(&np->timer);
 
 		disable_irq(irq);
 		spin_lock_irq(&np->lock);
diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index bea969d..bf03477 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -1527,7 +1527,7 @@ static int ns83820_stop(struct net_device *ndev)
 	struct ns83820 *dev = PRIV(ndev);
 
 	/* FIXME: protect against interrupt handler? */
-	del_timer_sync(&dev->tx_watchdog);
+	timer_delete_sync(&dev->tx_watchdog);
 
 	ns83820_disable_interrupts(dev);
 
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index f8016dc..3e55e8d 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -7019,7 +7019,7 @@ static void do_s2io_card_down(struct s2io_nic *sp, int do_io)
 	if (!is_s2io_card_up(sp))
 		return;
 
-	del_timer_sync(&sp->alarm_timer);
+	timer_delete_sync(&sp->alarm_timer);
 	/* If s2io_set_link task is executing, wait till it completes. */
 	while (test_and_set_bit(__S2IO_STATE_LINK_TASK, &(sp->state)))
 		msleep(50);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index abba165..95514fa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -227,7 +227,7 @@ static void nfp_net_reconfig_sync_enter(struct nfp_net *nn)
 	spin_unlock_bh(&nn->reconfig_lock);
 
 	if (cancelled_timer) {
-		del_timer_sync(&nn->reconfig_timer);
+		timer_delete_sync(&nn->reconfig_timer);
 		nfp_net_reconfig_wait(nn, nn->reconfig_timer.expires);
 	}
 
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 499e5e3..29cb74c 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5623,9 +5623,9 @@ static int nv_close(struct net_device *dev)
 	napi_disable(&np->napi);
 	synchronize_irq(np->pci_dev->irq);
 
-	del_timer_sync(&np->oom_kick);
-	del_timer_sync(&np->nic_poll);
-	del_timer_sync(&np->stats_poll);
+	timer_delete_sync(&np->oom_kick);
+	timer_delete_sync(&np->nic_poll);
+	timer_delete_sync(&np->stats_poll);
 
 	netif_stop_queue(dev);
 	spin_lock_irq(&np->lock);
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 4ac29cd..1651df8 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1916,7 +1916,7 @@ void pch_gbe_down(struct pch_gbe_adapter *adapter)
 	pch_gbe_irq_disable(adapter);
 	pch_gbe_free_irq(adapter);
 
-	del_timer_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
 
 	netdev->tx_queue_len = adapter->tx_queue_len;
 	netif_carrier_off(netdev);
diff --git a/drivers/net/ethernet/packetengines/hamachi.c b/drivers/net/ethernet/packetengines/hamachi.c
index a36d422..26bc8b3 100644
--- a/drivers/net/ethernet/packetengines/hamachi.c
+++ b/drivers/net/ethernet/packetengines/hamachi.c
@@ -1712,7 +1712,7 @@ static int hamachi_close(struct net_device *dev)
 
 	free_irq(hmp->pci_dev->irq, dev);
 
-	del_timer_sync(&hmp->timer);
+	timer_delete_sync(&hmp->timer);
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
diff --git a/drivers/net/ethernet/packetengines/yellowfin.c b/drivers/net/ethernet/packetengines/yellowfin.c
index c0515dc..21b760e 100644
--- a/drivers/net/ethernet/packetengines/yellowfin.c
+++ b/drivers/net/ethernet/packetengines/yellowfin.c
@@ -1222,7 +1222,7 @@ static int yellowfin_close(struct net_device *dev)
 	iowrite32(0x80000000, ioaddr + RxCtrl);
 	iowrite32(0x80000000, ioaddr + TxCtrl);
 
-	del_timer(&yp->timer);
+	timer_delete(&yp->timer);
 
 #if defined(__i386__)
 	if (yellowfin_debug > 2) {
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index cb4e12d..8013807 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1288,7 +1288,7 @@ static int pasemi_mac_close(struct net_device *dev)
 		phy_disconnect(dev->phydev);
 	}
 
-	del_timer_sync(&mac->tx->clean_timer);
+	timer_delete_sync(&mac->tx->clean_timer);
 
 	netif_stop_queue(dev);
 	napi_disable(&mac->napi);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index f5dc876..4c377bd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -441,7 +441,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 
 	set_bit(IONIC_LIF_F_FW_RESET, lif->state);
 
-	del_timer_sync(&ionic->watchdog_timer);
+	timer_delete_sync(&ionic->watchdog_timer);
 	cancel_work_sync(&lif->deferred.work);
 
 	mutex_lock(&lif->queue_lock);
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index fc78bc9..bf5bf8c 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3420,7 +3420,7 @@ static int ql_adapter_down(struct ql3_adapter *qdev, int do_reset)
 		pci_disable_msi(qdev->pdev);
 	}
 
-	del_timer_sync(&qdev->adapter_timer);
+	timer_delete_sync(&qdev->adapter_timer);
 
 	napi_disable(&qdev->napi);
 
diff --git a/drivers/net/ethernet/realtek/atp.c b/drivers/net/ethernet/realtek/atp.c
index 6cbcb31..c73a57e 100644
--- a/drivers/net/ethernet/realtek/atp.c
+++ b/drivers/net/ethernet/realtek/atp.c
@@ -832,7 +832,7 @@ net_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	del_timer_sync(&lp->timer);
+	timer_delete_sync(&lp->timer);
 
 	/* Flush the Tx and disable Rx here. */
 	lp->addr_mode = CMR2h_OFF;
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 8269904..d5db261 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2386,7 +2386,7 @@ static void ofdpa_fini(struct rocker *rocker)
 	struct hlist_node *tmp;
 	int bkt;
 
-	del_timer_sync(&ofdpa->fdb_cleanup_timer);
+	timer_delete_sync(&ofdpa->fdb_cleanup_timer);
 	flush_workqueue(rocker->rocker_owq);
 
 	spin_lock_irqsave(&ofdpa->flow_tbl_lock, flags);
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 12c8396..36b63bf 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -91,7 +91,7 @@ void sxgbe_disable_eee_mode(struct sxgbe_priv_data * const priv)
 {
 	/* Exit and disable EEE in case of we are in LPI state. */
 	priv->hw->mac->reset_eee_mode(priv->ioaddr);
-	del_timer_sync(&priv->eee_ctrl_timer);
+	timer_delete_sync(&priv->eee_ctrl_timer);
 	priv->tx_path_in_lpi_mode = false;
 }
 
@@ -1044,7 +1044,7 @@ static void sxgbe_tx_del_timer(struct sxgbe_priv_data *priv)
 
 	SXGBE_FOR_EACH_QUEUE(SXGBE_TX_QUEUES, queue_num) {
 		struct sxgbe_tx_queue *p = priv->txq[queue_num];
-		del_timer_sync(&p->txtimer);
+		timer_delete_sync(&p->txtimer);
 	}
 }
 
@@ -1208,7 +1208,7 @@ static int sxgbe_release(struct net_device *dev)
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 
 	if (priv->eee_enabled)
-		del_timer_sync(&priv->eee_ctrl_timer);
+		timer_delete_sync(&priv->eee_ctrl_timer);
 
 	/* Stop and disconnect the PHY */
 	if (dev->phydev) {
diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index 9319a26..1d65113 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -181,7 +181,7 @@ static void ether3_ledoff(struct timer_list *t)
  */
 static inline void ether3_ledon(struct net_device *dev)
 {
-	del_timer(&priv(dev)->timer);
+	timer_delete(&priv(dev)->timer);
 	priv(dev)->timer.expires = jiffies + HZ / 50; /* leave on for 1/50th second */
 	add_timer(&priv(dev)->timer);
 	if (priv(dev)->regs.config2 & CFG2_CTRLO)
@@ -454,7 +454,7 @@ static void ether3_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	unsigned long flags;
 
-	del_timer(&priv(dev)->timer);
+	timer_delete(&priv(dev)->timer);
 
 	local_irq_save(flags);
 	printk(KERN_ERR "%s: transmit timed out, network cable problem?\n", dev->name);
@@ -851,7 +851,7 @@ static void ether3_remove(struct expansion_card *ec)
 	ecard_set_drvdata(ec, NULL);
 
 	unregister_netdev(dev);
-	del_timer_sync(&priv(dev)->timer);
+	timer_delete_sync(&priv(dev)->timer);
 	free_netdev(dev);
 	ecard_release_resources(ec);
 }
diff --git a/drivers/net/ethernet/sfc/falcon/falcon.c b/drivers/net/ethernet/sfc/falcon/falcon.c
index 4af5633..b865275 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon.c
@@ -2657,7 +2657,7 @@ void falcon_stop_nic_stats(struct ef4_nic *efx)
 	++nic_data->stats_disable_count;
 	spin_unlock_bh(&efx->stats_lock);
 
-	del_timer_sync(&nic_data->stats_timer);
+	timer_delete_sync(&nic_data->stats_timer);
 
 	/* Wait enough time for the most recent transfer to
 	 * complete. */
diff --git a/drivers/net/ethernet/sfc/falcon/rx.c b/drivers/net/ethernet/sfc/falcon/rx.c
index 6bbdb5d..38ad7ac 100644
--- a/drivers/net/ethernet/sfc/falcon/rx.c
+++ b/drivers/net/ethernet/sfc/falcon/rx.c
@@ -791,7 +791,7 @@ void ef4_fini_rx_queue(struct ef4_rx_queue *rx_queue)
 	netif_dbg(rx_queue->efx, drv, rx_queue->efx->net_dev,
 		  "shutting down RX queue %d\n", ef4_rx_queue_index(rx_queue));
 
-	del_timer_sync(&rx_queue->slow_fill);
+	timer_delete_sync(&rx_queue->slow_fill);
 
 	/* Release RX buffers from the current read ptr to the write ptr */
 	if (rx_queue->buffer) {
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index dbd2ee9..dcef058 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -530,7 +530,7 @@ static bool efx_mcdi_complete_async(struct efx_mcdi_iface *mcdi, bool timeout)
 	 * of it aborting the next request.
 	 */
 	if (!timeout)
-		del_timer_sync(&mcdi->async_timer);
+		timer_delete_sync(&mcdi->async_timer);
 
 	spin_lock(&mcdi->async_lock);
 	async = list_first_entry(&mcdi->async_list,
@@ -1122,7 +1122,7 @@ void efx_mcdi_flush_async(struct efx_nic *efx)
 	/* We must be in poll or fail mode so no more requests can be queued */
 	BUG_ON(mcdi->mode == MCDI_MODE_EVENTS);
 
-	del_timer_sync(&mcdi->async_timer);
+	timer_delete_sync(&mcdi->async_timer);
 
 	/* If a request is still running, make sure we give the MC
 	 * time to complete it so that the response won't overwrite our
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index 4cc8320..8eb272b 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -285,7 +285,7 @@ void efx_fini_rx_queue(struct efx_rx_queue *rx_queue)
 	netif_dbg(rx_queue->efx, drv, rx_queue->efx->net_dev,
 		  "shutting down RX queue %d\n", efx_rx_queue_index(rx_queue));
 
-	del_timer_sync(&rx_queue->slow_fill);
+	timer_delete_sync(&rx_queue->slow_fill);
 	if (rx_queue->grant_credits)
 		flush_work(&rx_queue->grant_work);
 
diff --git a/drivers/net/ethernet/sfc/siena/mcdi.c b/drivers/net/ethernet/sfc/siena/mcdi.c
index 3f7899d..99ab5f2 100644
--- a/drivers/net/ethernet/sfc/siena/mcdi.c
+++ b/drivers/net/ethernet/sfc/siena/mcdi.c
@@ -534,7 +534,7 @@ static bool efx_mcdi_complete_async(struct efx_mcdi_iface *mcdi, bool timeout)
 	 * of it aborting the next request.
 	 */
 	if (!timeout)
-		del_timer_sync(&mcdi->async_timer);
+		timer_delete_sync(&mcdi->async_timer);
 
 	spin_lock(&mcdi->async_lock);
 	async = list_first_entry(&mcdi->async_list,
@@ -1145,7 +1145,7 @@ void efx_siena_mcdi_flush_async(struct efx_nic *efx)
 	/* We must be in poll or fail mode so no more requests can be queued */
 	BUG_ON(mcdi->mode == MCDI_MODE_EVENTS);
 
-	del_timer_sync(&mcdi->async_timer);
+	timer_delete_sync(&mcdi->async_timer);
 
 	/* If a request is still running, make sure we give the MC
 	 * time to complete it so that the response won't overwrite our
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 2839d0e..ab493e5 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -284,7 +284,7 @@ void efx_siena_fini_rx_queue(struct efx_rx_queue *rx_queue)
 	netif_dbg(rx_queue->efx, drv, rx_queue->efx->net_dev,
 		  "shutting down RX queue %d\n", efx_rx_queue_index(rx_queue));
 
-	del_timer_sync(&rx_queue->slow_fill);
+	timer_delete_sync(&rx_queue->slow_fill);
 
 	/* Release RX buffers from the current read ptr to the write ptr */
 	if (rx_queue->buffer) {
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 4535579..7196e1c 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -718,7 +718,7 @@ static void ioc3_init(struct net_device *dev)
 	struct ioc3_private *ip = netdev_priv(dev);
 	struct ioc3_ethregs *regs = ip->regs;
 
-	del_timer_sync(&ip->ioc3_timer);	/* Kill if running	*/
+	timer_delete_sync(&ip->ioc3_timer);	/* Kill if running	*/
 
 	writel(EMCR_RST, &regs->emcr);		/* Reset		*/
 	readl(&regs->emcr);			/* Flush WB		*/
@@ -801,7 +801,7 @@ static int ioc3_close(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 
-	del_timer_sync(&ip->ioc3_timer);
+	timer_delete_sync(&ip->ioc3_timer);
 
 	netif_stop_queue(dev);
 
@@ -950,7 +950,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 	return 0;
 
 out_stop:
-	del_timer_sync(&ip->ioc3_timer);
+	timer_delete_sync(&ip->ioc3_timer);
 	if (ip->rxr)
 		dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr,
 				  ip->rxr_dma);
@@ -971,7 +971,7 @@ static void ioc3eth_remove(struct platform_device *pdev)
 	dma_free_coherent(ip->dma_dev, TX_RING_SIZE + SZ_16K - 1, ip->tx_ring, ip->txr_dma);
 
 	unregister_netdev(dev);
-	del_timer_sync(&ip->ioc3_timer);
+	timer_delete_sync(&ip->ioc3_timer);
 	free_netdev(dev);
 }
 
diff --git a/drivers/net/ethernet/sis/sis190.c b/drivers/net/ethernet/sis/sis190.c
index dda4e48..d10b147 100644
--- a/drivers/net/ethernet/sis/sis190.c
+++ b/drivers/net/ethernet/sis/sis190.c
@@ -758,7 +758,7 @@ static irqreturn_t sis190_irq(int irq, void *__dev)
 
 	if (status & LinkChange) {
 		netif_info(tp, intr, dev, "link change\n");
-		del_timer(&tp->timer);
+		timer_delete(&tp->timer);
 		schedule_work(&tp->phy_task);
 	}
 
@@ -1034,7 +1034,7 @@ static inline void sis190_delete_timer(struct net_device *dev)
 {
 	struct sis190_private *tp = netdev_priv(dev);
 
-	del_timer_sync(&tp->timer);
+	timer_delete_sync(&tp->timer);
 }
 
 static inline void sis190_request_timer(struct net_device *dev)
diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 85b8503..332cbd7 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -1983,7 +1983,7 @@ static int sis900_close(struct net_device *net_dev)
 	/* Stop the chip's Tx and Rx Status Machine */
 	sw32(cr, RxDIS | TxDIS | sr32(cr));
 
-	del_timer(&sis_priv->timer);
+	timer_delete(&sis_priv->timer);
 
 	free_irq(pdev->irq, net_dev);
 
diff --git a/drivers/net/ethernet/smsc/epic100.c b/drivers/net/ethernet/smsc/epic100.c
index 013e90d..ca0ab3a 100644
--- a/drivers/net/ethernet/smsc/epic100.c
+++ b/drivers/net/ethernet/smsc/epic100.c
@@ -1292,7 +1292,7 @@ static int epic_close(struct net_device *dev)
 		netdev_dbg(dev, "Shutting down ethercard, status was %2.2x.\n",
 			   er32(INTSTAT));
 
-	del_timer_sync(&ep->timer);
+	timer_delete_sync(&ep->timer);
 
 	epic_disable_int(dev, ep);
 
diff --git a/drivers/net/ethernet/smsc/smc91c92_cs.c b/drivers/net/ethernet/smsc/smc91c92_cs.c
index 86e3ec2..6fa957f 100644
--- a/drivers/net/ethernet/smsc/smc91c92_cs.c
+++ b/drivers/net/ethernet/smsc/smc91c92_cs.c
@@ -1105,7 +1105,7 @@ static int smc_close(struct net_device *dev)
     outw(CTL_POWERDOWN, ioaddr + CONTROL );
 
     link->open--;
-    del_timer_sync(&smc->media);
+    timer_delete_sync(&smc->media);
 
     return 0;
 } /* smc_close */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2795326..59d07d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -467,7 +467,7 @@ static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
  */
 static void stmmac_stop_sw_lpi(struct stmmac_priv *priv)
 {
-	del_timer_sync(&priv->eee_ctrl_timer);
+	timer_delete_sync(&priv->eee_ctrl_timer);
 	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 }
@@ -1082,7 +1082,7 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 
 	netdev_dbg(priv->dev, "disable EEE\n");
 	priv->eee_sw_timer_en = false;
-	del_timer_sync(&priv->eee_ctrl_timer);
+	timer_delete_sync(&priv->eee_ctrl_timer);
 	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 
@@ -7842,7 +7842,7 @@ int stmmac_suspend(struct device *dev)
 
 	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
+		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
 	/* Stop TX/RX DMA */
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index b8948d5..b777e5a 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -3779,7 +3779,7 @@ static void cas_shutdown(struct cas *cp)
 	/* Make us not-running to avoid timers respawning */
 	cp->hw_running = 0;
 
-	del_timer_sync(&cp->link_timer);
+	timer_delete_sync(&cp->link_timer);
 
 	/* Stop the reset task */
 #if 0
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index a9a6670..6fc37ab 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -390,7 +390,7 @@ static int vsw_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	return 0;
 
 err_out_del_timer:
-	del_timer_sync(&port->clean_timer);
+	timer_delete_sync(&port->clean_timer);
 	list_del_rcu(&port->list);
 	synchronize_rcu();
 	netif_napi_del(&port->napi);
@@ -408,8 +408,8 @@ static void vsw_port_remove(struct vio_dev *vdev)
 	unsigned long flags;
 
 	if (port) {
-		del_timer_sync(&port->vio.timer);
-		del_timer_sync(&port->clean_timer);
+		timer_delete_sync(&port->vio.timer);
+		timer_delete_sync(&port->clean_timer);
 
 		napi_disable(&port->napi);
 		unregister_netdev(port->dev);
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 72177fe..73c07f1 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6165,7 +6165,7 @@ static void niu_full_shutdown(struct niu *np, struct net_device *dev)
 	niu_disable_napi(np);
 	netif_tx_stop_all_queues(dev);
 
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 
 	spin_lock_irq(&np->lock);
 
@@ -6511,7 +6511,7 @@ static void niu_reset_task(struct work_struct *work)
 
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 
 	niu_netif_stop(np);
 
@@ -9914,7 +9914,7 @@ static int __maybe_unused niu_suspend(struct device *dev_d)
 	flush_work(&np->reset_task);
 	niu_netif_stop(np);
 
-	del_timer_sync(&np->timer);
+	timer_delete_sync(&np->timer);
 
 	spin_lock_irqsave(&np->lock, flags);
 	niu_enable_interrupts(np, 0);
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index bbb3a6c..d2c8210 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -931,7 +931,7 @@ static int bigmac_close(struct net_device *dev)
 {
 	struct bigmac *bp = netdev_priv(dev);
 
-	del_timer(&bp->bigmac_timer);
+	timer_delete(&bp->bigmac_timer);
 	bp->timer_state = asleep;
 	bp->timer_ticks = 0;
 
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 3e5f9b1..06579d7 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2180,7 +2180,7 @@ static void gem_do_stop(struct net_device *dev, int wol)
 	gem_disable_ints(gp);
 
 	/* Stop the link timer */
-	del_timer_sync(&gp->link_timer);
+	timer_delete_sync(&gp->link_timer);
 
 	/* We cannot cancel the reset task while holding the
 	 * rtnl lock, we'd get an A->B / B->A deadlock stituation
@@ -2230,7 +2230,7 @@ static void gem_reset_task(struct work_struct *work)
 	}
 
 	/* Stop the link timer */
-	del_timer_sync(&gp->link_timer);
+	timer_delete_sync(&gp->link_timer);
 
 	/* Stop NAPI and tx */
 	gem_netif_stop(gp);
@@ -2610,7 +2610,7 @@ static int gem_set_link_ksettings(struct net_device *dev,
 
 	/* Apply settings and restart link process. */
 	if (netif_device_present(gp->dev)) {
-		del_timer_sync(&gp->link_timer);
+		timer_delete_sync(&gp->link_timer);
 		gem_begin_auto_negotiation(gp, cmd);
 	}
 
@@ -2626,7 +2626,7 @@ static int gem_nway_reset(struct net_device *dev)
 
 	/* Restart link process  */
 	if (netif_device_present(gp->dev)) {
-		del_timer_sync(&gp->link_timer);
+		timer_delete_sync(&gp->link_timer);
 		gem_begin_auto_negotiation(gp, NULL);
 	}
 
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 50ace46..9a75866 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -1265,7 +1265,7 @@ static int happy_meal_init(struct happy_meal *hp)
 	u32 regtmp, rxcfg;
 
 	/* If auto-negotiation timer is running, kill it. */
-	del_timer(&hp->happy_timer);
+	timer_delete(&hp->happy_timer);
 
 	HMD("happy_flags[%08x]\n", hp->happy_flags);
 	if (!(hp->happy_flags & HFLAG_INIT)) {
@@ -1922,7 +1922,7 @@ static int happy_meal_close(struct net_device *dev)
 	happy_meal_clean_rings(hp);
 
 	/* If auto-negotiation timer is running, kill it. */
-	del_timer(&hp->happy_timer);
+	timer_delete(&hp->happy_timer);
 
 	spin_unlock_irq(&hp->happy_lock);
 
@@ -2184,7 +2184,7 @@ static int hme_set_link_ksettings(struct net_device *dev,
 
 	/* Ok, do it to it. */
 	spin_lock_irq(&hp->happy_lock);
-	del_timer(&hp->happy_timer);
+	timer_delete(&hp->happy_timer);
 	happy_meal_begin_auto_negotiation(hp, hp->tcvregs, cmd);
 	spin_unlock_irq(&hp->happy_lock);
 
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 1e887d9..a2a3e94 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -505,7 +505,7 @@ static void vnet_port_remove(struct vio_dev *vdev)
 	struct vnet_port *port = dev_get_drvdata(&vdev->dev);
 
 	if (port) {
-		del_timer_sync(&port->vio.timer);
+		timer_delete_sync(&port->vio.timer);
 
 		napi_disable(&port->napi);
 
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 1cacb2a..ddc6d46 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1058,7 +1058,7 @@ void sunvnet_clean_timer_expire_common(struct timer_list *t)
 		(void)mod_timer(&port->clean_timer,
 				jiffies + VNET_CLEAN_TIMEOUT);
 	 else
-		del_timer(&port->clean_timer);
+		timer_delete(&port->clean_timer);
 }
 EXPORT_SYMBOL_GPL(sunvnet_clean_timer_expire_common);
 
@@ -1513,7 +1513,7 @@ out_dropped:
 		(void)mod_timer(&port->clean_timer,
 				jiffies + VNET_CLEAN_TIMEOUT);
 	else if (port)
-		del_timer(&port->clean_timer);
+		timer_delete(&port->clean_timer);
 	rcu_read_unlock();
 	dev_kfree_skb(skb);
 	vnet_free_skbs(freeskbs);
@@ -1707,7 +1707,7 @@ EXPORT_SYMBOL_GPL(sunvnet_port_free_tx_bufs_common);
 
 void vnet_port_reset(struct vnet_port *port)
 {
-	del_timer(&port->clean_timer);
+	timer_delete(&port->clean_timer);
 	sunvnet_port_free_tx_bufs_common(port);
 	port->rmtu = 0;
 	port->tso = (port->vsw == 0);  /* no tso in vsw, misbehaves in bridge */
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
index d1793b6..24e4b24 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
@@ -405,7 +405,7 @@ static void xlgmac_stop_timers(struct xlgmac_pdata *pdata)
 		if (!channel->tx_ring)
 			break;
 
-		del_timer_sync(&channel->tx_timer);
+		timer_delete_sync(&channel->tx_timer);
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5cc72a9..7f77694 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -1287,7 +1287,7 @@ static void cpsw_ale_aging_stop(struct cpsw_ale *ale)
 		return;
 	}
 
-	del_timer_sync(&ale->timer);
+	timer_delete_sync(&ale->timer);
 }
 
 void cpsw_ale_start(struct cpsw_ale *ale)
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 63e686f..fd2b745 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3796,7 +3796,7 @@ static int gbe_remove(struct netcp_device *netcp_device, void *inst_priv)
 {
 	struct gbe_priv *gbe_dev = inst_priv;
 
-	del_timer_sync(&gbe_dev->timer);
+	timer_delete_sync(&gbe_dev->timer);
 	cpts_release(gbe_dev->cpts);
 	cpsw_ale_stop(gbe_dev->ale);
 	netcp_txpipe_close(&gbe_dev->tx_pipe);
diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index b3da76e..d9240fb 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -332,13 +332,13 @@ static void tlan_stop(struct net_device *dev)
 {
 	struct tlan_priv *priv = netdev_priv(dev);
 
-	del_timer_sync(&priv->media_timer);
+	timer_delete_sync(&priv->media_timer);
 	tlan_read_and_clear_stats(dev, TLAN_RECORD);
 	outl(TLAN_HC_AD_RST, dev->base_addr + TLAN_HOST_CMD);
 	/* Reset and power down phy */
 	tlan_reset_adapter(dev);
 	if (priv->timer.function != NULL) {
-		del_timer_sync(&priv->timer);
+		timer_delete_sync(&priv->timer);
 		priv->timer.function = NULL;
 	}
 }
diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index c6957e3..7ec0e3c 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -1379,7 +1379,7 @@ static int tsi108_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	napi_disable(&data->napi);
 
-	del_timer_sync(&data->timer);
+	timer_delete_sync(&data->timer);
 
 	tsi108_stop_ethernet(dev);
 	tsi108_kill_phy(dev);
diff --git a/drivers/net/fddi/defza.c b/drivers/net/fddi/defza.c
index f5c25ac..54b7f24 100644
--- a/drivers/net/fddi/defza.c
+++ b/drivers/net/fddi/defza.c
@@ -983,7 +983,7 @@ static irqreturn_t fza_interrupt(int irq, void *dev_id)
 
 		case FZA_STATE_UNINITIALIZED:
 			netif_carrier_off(dev);
-			del_timer_sync(&fp->reset_timer);
+			timer_delete_sync(&fp->reset_timer);
 			fp->ring_cmd_index = 0;
 			fp->ring_uns_index = 0;
 			fp->ring_rmc_tx_index = 0;
@@ -1017,7 +1017,7 @@ static irqreturn_t fza_interrupt(int irq, void *dev_id)
 			fp->queue_active = 0;
 			netif_stop_queue(dev);
 			pr_debug("%s: queue stopped\n", fp->name);
-			del_timer_sync(&fp->reset_timer);
+			timer_delete_sync(&fp->reset_timer);
 			pr_warn("%s: halted, reason: %x\n", fp->name,
 				FZA_STATUS_GET_HALT(status));
 			fza_regs_dump(fp);
@@ -1227,7 +1227,7 @@ static int fza_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	pr_debug("%s: queue stopped\n", fp->name);
 
-	del_timer_sync(&fp->reset_timer);
+	timer_delete_sync(&fp->reset_timer);
 	spin_lock_irqsave(&fp->lock, flags);
 	fp->state = FZA_STATE_UNINITIALIZED;
 	fp->state_chg_flag = 0;
@@ -1493,7 +1493,7 @@ static int fza_probe(struct device *bdev)
 	return 0;
 
 err_out_irq:
-	del_timer_sync(&fp->reset_timer);
+	timer_delete_sync(&fp->reset_timer);
 	fza_do_shutdown(fp);
 	free_irq(dev->irq, dev);
 
@@ -1520,7 +1520,7 @@ static int fza_remove(struct device *bdev)
 
 	unregister_netdev(dev);
 
-	del_timer_sync(&fp->reset_timer);
+	timer_delete_sync(&fp->reset_timer);
 	fza_do_shutdown(fp);
 	free_irq(dev->irq, dev);
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 3bf6785..b33d84e 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -660,8 +660,8 @@ static void sixpack_close(struct tty_struct *tty)
 
 	unregister_netdev(sp->dev);
 
-	del_timer_sync(&sp->tx_t);
-	del_timer_sync(&sp->resync_t);
+	timer_delete_sync(&sp->tx_t);
+	timer_delete_sync(&sp->resync_t);
 
 	/* Free all 6pack frame buffers after unreg. */
 	kfree(sp->xbuff);
@@ -937,7 +937,7 @@ sixpack_decode(struct sixpack *sp, const u8 *pre_rbuff, size_t count)
 		inbyte = pre_rbuff[count1];
 		if (inbyte == SIXP_FOUND_TNC) {
 			tnc_set_sync_state(sp, TNC_IN_SYNC);
-			del_timer(&sp->resync_t);
+			timer_delete(&sp->resync_t);
 		}
 		if ((inbyte & SIXP_PRIO_CMD_MASK) != 0)
 			decode_prio_command(sp, inbyte);
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index c71e522..f88721d 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -794,8 +794,8 @@ static inline void init_brg(struct scc_channel *scc)
  
 static void init_channel(struct scc_channel *scc)
 {
-	del_timer(&scc->tx_t);
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_t);
+	timer_delete(&scc->tx_wdog);
 
 	disable_irq(scc->irq);
 
@@ -999,7 +999,7 @@ static void __scc_start_tx_timer(struct scc_channel *scc,
 				 void (*handler)(struct timer_list *t),
 				 unsigned long when)
 {
-	del_timer(&scc->tx_t);
+	timer_delete(&scc->tx_t);
 
 	if (when == 0)
 	{
@@ -1029,7 +1029,7 @@ static void scc_start_defer(struct scc_channel *scc)
 	unsigned long flags;
 	
 	spin_lock_irqsave(&scc->lock, flags);
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 	
 	if (scc->kiss.maxdefer != 0 && scc->kiss.maxdefer != TIMER_OFF)
 	{
@@ -1045,7 +1045,7 @@ static void scc_start_maxkeyup(struct scc_channel *scc)
 	unsigned long flags;
 	
 	spin_lock_irqsave(&scc->lock, flags);
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 	
 	if (scc->kiss.maxkeyup != 0 && scc->kiss.maxkeyup != TIMER_OFF)
 	{
@@ -1194,7 +1194,7 @@ static void t_tail(struct timer_list *t)
 	unsigned long flags;
 	
 	spin_lock_irqsave(&scc->lock, flags); 
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 	scc_key_trx(scc, TX_OFF);
 	spin_unlock_irqrestore(&scc->lock, flags);
 
@@ -1219,7 +1219,7 @@ static void t_busy(struct timer_list *t)
 {
 	struct scc_channel *scc = from_timer(scc, t, tx_wdog);
 
-	del_timer(&scc->tx_t);
+	timer_delete(&scc->tx_t);
 	netif_stop_queue(scc->dev);	/* don't pile on the wabbit! */
 
 	scc_discard_buffers(scc);
@@ -1248,7 +1248,7 @@ static void t_maxkeyup(struct timer_list *t)
 	netif_stop_queue(scc->dev);
 	scc_discard_buffers(scc);
 
-	del_timer(&scc->tx_t);
+	timer_delete(&scc->tx_t);
 
 	cl(scc, R1, TxINT_ENAB);	/* force an ABORT, but don't */
 	cl(scc, R15, TxUIE);		/* count it. */
@@ -1272,7 +1272,7 @@ static void t_idle(struct timer_list *t)
 {
 	struct scc_channel *scc = from_timer(scc, t, tx_t);
 	
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 
 	scc_key_trx(scc, TX_OFF);
 	if(scc->kiss.mintime)
@@ -1407,7 +1407,7 @@ static void scc_stop_calibrate(struct timer_list *t)
 	unsigned long flags;
 	
 	spin_lock_irqsave(&scc->lock, flags);
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 	scc_key_trx(scc, TX_OFF);
 	wr(scc, R6, 0);
 	wr(scc, R7, FLAG);
@@ -1428,7 +1428,7 @@ scc_start_calibrate(struct scc_channel *scc, int duration, unsigned char pattern
 	netif_stop_queue(scc->dev);
 	scc_discard_buffers(scc);
 
-	del_timer(&scc->tx_wdog);
+	timer_delete(&scc->tx_wdog);
 
 	scc->tx_wdog.function = scc_stop_calibrate;
 	scc->tx_wdog.expires = jiffies + HZ*duration;
@@ -1609,8 +1609,8 @@ static int scc_net_close(struct net_device *dev)
 	wr(scc,R3,0);
 	spin_unlock_irqrestore(&scc->lock, flags);
 
-	del_timer_sync(&scc->tx_t);
-	del_timer_sync(&scc->tx_wdog);
+	timer_delete_sync(&scc->tx_t);
+	timer_delete_sync(&scc->tx_wdog);
 	
 	scc_discard_buffers(scc);
 
diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 2ed2f83..f29997b 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -1158,7 +1158,7 @@ static void __exit yam_cleanup_driver(void)
 	struct yam_mcs *p;
 	int i;
 
-	del_timer_sync(&yam_timer);
+	timer_delete_sync(&yam_timer);
 	for (i = 0; i < NR_PORTS; i++) {
 		struct net_device *dev = yam_devs[i];
 		if (dev) {
diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index aa8f828..6342c31 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1357,7 +1357,7 @@ static int rr_close(struct net_device *dev)
 	rrpriv->fw_running = 0;
 
 	spin_unlock_irqrestore(&rrpriv->lock, flags);
-	del_timer_sync(&rrpriv->timer);
+	timer_delete_sync(&rrpriv->timer);
 	spin_lock_irqsave(&rrpriv->lock, flags);
 
 	writel(0, &regs->TxPi);
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index ef6df0e..ef42046 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -291,7 +291,7 @@ static int ntb_netdev_close(struct net_device *ndev)
 	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
 		dev_kfree_skb(skb);
 
-	del_timer_sync(&dev->tx_timer);
+	timer_delete_sync(&dev->tx_timer);
 
 	return 0;
 }
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 69ca765..b68369e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -952,7 +952,7 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 static void phylink_pcs_poll_stop(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_INBAND)
-		del_timer(&pl->link_poll);
+		timer_delete(&pl->link_poll);
 }
 
 static void phylink_pcs_poll_start(struct phylink *pl)
@@ -2448,7 +2448,7 @@ void phylink_stop(struct phylink *pl)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
 		phy_stop(pl->phydev);
-	del_timer_sync(&pl->link_poll);
+	timer_delete_sync(&pl->link_poll);
 	if (pl->link_irq) {
 		free_irq(pl->link_irq, pl);
 		pl->link_irq = 0;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index fb362ee..3cfa17c 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -899,8 +899,8 @@ static void slip_close(struct tty_struct *tty)
 
 	/* VSV = very important to remove timers */
 #ifdef CONFIG_SLIP_SMART
-	del_timer_sync(&sl->keepalive_timer);
-	del_timer_sync(&sl->outfill_timer);
+	timer_delete_sync(&sl->keepalive_timer);
+	timer_delete_sync(&sl->outfill_timer);
 #endif
 	/* Flush network side */
 	unregister_netdev(sl->dev);
@@ -1137,7 +1137,7 @@ static int slip_ioctl(struct tty_struct *tty, unsigned int cmd,
 					jiffies + sl->keepalive * HZ);
 			set_bit(SLF_KEEPTEST, &sl->flags);
 		} else
-			del_timer(&sl->keepalive_timer);
+			timer_delete(&sl->keepalive_timer);
 		spin_unlock_bh(&sl->lock);
 		return 0;
 
@@ -1162,7 +1162,7 @@ static int slip_ioctl(struct tty_struct *tty, unsigned int cmd,
 						jiffies + sl->outfill * HZ);
 			set_bit(SLF_OUTWAIT, &sl->flags);
 		} else
-			del_timer(&sl->outfill_timer);
+			timer_delete(&sl->outfill_timer);
 		spin_unlock_bh(&sl->lock);
 		return 0;
 
@@ -1217,7 +1217,7 @@ static int sl_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 						jiffies + sl->keepalive * HZ);
 			set_bit(SLF_KEEPTEST, &sl->flags);
 		} else
-			del_timer(&sl->keepalive_timer);
+			timer_delete(&sl->keepalive_timer);
 		break;
 
 	case SIOCGKEEPALIVE:
@@ -1235,7 +1235,7 @@ static int sl_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 						jiffies + sl->outfill * HZ);
 			set_bit(SLF_OUTWAIT, &sl->flags);
 		} else
-			del_timer(&sl->outfill_timer);
+			timer_delete(&sl->outfill_timer);
 		break;
 
 	case SIOCGOUTFILL:
@@ -1421,7 +1421,7 @@ static void sl_keepalive(struct timer_list *t)
 			/* keepalive still high :(, we must hangup */
 			if (sl->outfill)
 				/* outfill timer must be deleted too */
-				(void)del_timer(&sl->outfill_timer);
+				(void) timer_delete(&sl->outfill_timer);
 			printk(KERN_DEBUG "%s: no packets received during keepalive timeout, hangup.\n", sl->dev->name);
 			/* this must hangup tty & close slip */
 			tty_hangup(sl->tty);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f75f912..7babd1e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1295,7 +1295,7 @@ static void tun_flow_init(struct tun_struct *tun)
 
 static void tun_flow_uninit(struct tun_struct *tun)
 {
-	del_timer_sync(&tun->flow_gc_timer);
+	timer_delete_sync(&tun->flow_gc_timer);
 	tun_flow_flush(tun);
 }
 
diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index ff439ef..fc5e441 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -738,7 +738,7 @@ static int catc_stop(struct net_device *netdev)
 	netif_stop_queue(netdev);
 
 	if (!catc->is_f5u011)
-		del_timer_sync(&catc->timer);
+		timer_delete_sync(&catc->timer);
 
 	usb_kill_urb(catc->rx_urb);
 	usb_kill_urb(catc->tx_urb);
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 137adf6..e4f1663 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1661,7 +1661,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		if (ret < 0)
 			return ret;
 
-		del_timer(&dev->stat_monitor);
+		timer_delete(&dev->stat_monitor);
 	} else if (link && !dev->link_on) {
 		dev->link_on = true;
 
@@ -3304,7 +3304,7 @@ static int lan78xx_stop(struct net_device *net)
 	mutex_lock(&dev->dev_mutex);
 
 	if (timer_pending(&dev->stat_monitor))
-		del_timer_sync(&dev->stat_monitor);
+		timer_delete_sync(&dev->stat_monitor);
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
@@ -4938,7 +4938,7 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 		/* reattach */
 		netif_device_attach(dev->net);
 
-		del_timer(&dev->stat_monitor);
+		timer_delete(&dev->stat_monitor);
 
 		if (PMSG_IS_AUTO(message)) {
 			ret = lan78xx_set_auto_suspend(dev);
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 3d239b8..dec6e82 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -522,7 +522,7 @@ static void sierra_net_kevent(struct work_struct *work)
 						" stopping sync timer",
 						hh.msgspecific.byte);
 				/* Got sync resp - stop timer & clear mask */
-				del_timer_sync(&priv->sync_timer);
+				timer_delete_sync(&priv->sync_timer);
 				clear_bit(SIERRA_NET_TIMER_EXPIRY,
 					  &priv->kevent_flags);
 				break;
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index aeab230..6b8ec81 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -860,7 +860,7 @@ int usbnet_stop (struct net_device *net)
 
 	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
-	del_timer_sync(&dev->delay);
+	timer_delete_sync(&dev->delay);
 	tasklet_kill(&dev->bh);
 	cancel_work_sync(&dev->kevent);
 
@@ -869,7 +869,7 @@ int usbnet_stop (struct net_device *net)
 	 * we have a flag
 	 */
 	tasklet_kill(&dev->bh);
-	del_timer_sync(&dev->delay);
+	timer_delete_sync(&dev->delay);
 	cancel_work_sync(&dev->kevent);
 
 	if (!pm)
@@ -1882,7 +1882,7 @@ out1:
 	 */
 	usbnet_mark_going_away(dev);
 	cancel_work_sync(&dev->kevent);
-	del_timer_sync(&dev->delay);
+	timer_delete_sync(&dev->delay);
 	free_netdev(net);
 out:
 	return status;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8c49e90..9ccc3f0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3193,7 +3193,7 @@ static int vxlan_stop(struct net_device *dev)
 
 	vxlan_multicast_leave(vxlan);
 
-	del_timer_sync(&vxlan->age_timer);
+	timer_delete_sync(&vxlan->age_timer);
 
 	vxlan_flush(vxlan, &desc);
 	vxlan_sock_release(vxlan);
diff --git a/drivers/net/wan/hdlc_cisco.c b/drivers/net/wan/hdlc_cisco.c
index cdebe65..7e65343 100644
--- a/drivers/net/wan/hdlc_cisco.c
+++ b/drivers/net/wan/hdlc_cisco.c
@@ -285,7 +285,7 @@ static void cisco_stop(struct net_device *dev)
 	struct cisco_state *st = state(hdlc);
 	unsigned long flags;
 
-	del_timer_sync(&st->timer);
+	timer_delete_sync(&st->timer);
 
 	spin_lock_irqsave(&st->lock, flags);
 	netif_dormant_on(dev);
diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 81e72bc..34014f4 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -1025,7 +1025,7 @@ static void fr_stop(struct net_device *dev)
 	printk(KERN_DEBUG "fr_stop\n");
 #endif
 	if (state(hdlc)->settings.lmi != LMI_NONE)
-		del_timer_sync(&state(hdlc)->timer);
+		timer_delete_sync(&state(hdlc)->timer);
 	fr_set_link_state(0, dev);
 }
 
diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 37a3c98..19921b0 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -358,7 +358,7 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
 		}
 	}
 	if (old_state != CLOSED && proto->state == CLOSED)
-		del_timer(&proto->timer);
+		timer_delete(&proto->timer);
 
 #if DEBUG_STATE
 	printk(KERN_DEBUG "%s: %s ppp_cp_event(%s) ... %s\n", dev->name,
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index c496d35..3ffeeba 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -81,7 +81,7 @@ static int wg_pm_notification(struct notifier_block *nb, unsigned long action, v
 	list_for_each_entry(wg, &device_list, device_list) {
 		mutex_lock(&wg->device_update_lock);
 		list_for_each_entry(peer, &wg->peer_list, peer_list) {
-			del_timer(&peer->timer_zero_key_material);
+			timer_delete(&peer->timer_zero_key_material);
 			wg_noise_handshake_clear(&peer->handshake);
 			wg_noise_keypairs_clear(&peer->keypairs);
 		}
diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index 968bdb4..a9e0890 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -48,7 +48,7 @@ static void wg_expired_retransmit_handshake(struct timer_list *timer)
 			 peer->device->dev->name, peer->internal_id,
 			 &peer->endpoint.addr, (int)MAX_TIMER_HANDSHAKES + 2);
 
-		del_timer(&peer->timer_send_keepalive);
+		timer_delete(&peer->timer_send_keepalive);
 		/* We drop all packets without a keypair and don't try again,
 		 * if we try unsuccessfully for too long to make a handshake.
 		 */
@@ -167,7 +167,7 @@ void wg_timers_data_received(struct wg_peer *peer)
  */
 void wg_timers_any_authenticated_packet_sent(struct wg_peer *peer)
 {
-	del_timer(&peer->timer_send_keepalive);
+	timer_delete(&peer->timer_send_keepalive);
 }
 
 /* Should be called after any type of authenticated packet is received, whether
@@ -175,7 +175,7 @@ void wg_timers_any_authenticated_packet_sent(struct wg_peer *peer)
  */
 void wg_timers_any_authenticated_packet_received(struct wg_peer *peer)
 {
-	del_timer(&peer->timer_new_handshake);
+	timer_delete(&peer->timer_new_handshake);
 }
 
 /* Should be called after a handshake initiation message is sent. */
@@ -191,7 +191,7 @@ void wg_timers_handshake_initiated(struct wg_peer *peer)
  */
 void wg_timers_handshake_complete(struct wg_peer *peer)
 {
-	del_timer(&peer->timer_retransmit_handshake);
+	timer_delete(&peer->timer_retransmit_handshake);
 	peer->timer_handshake_attempts = 0;
 	peer->sent_lastminute_handshake = false;
 	ktime_get_real_ts64(&peer->walltime_last_handshake);
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 156f365..96dc277 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -733,7 +733,7 @@ static void ar5523_data_tx_pkt_put(struct ar5523 *ar)
 {
 	atomic_dec(&ar->tx_nr_total);
 	if (!atomic_dec_return(&ar->tx_nr_pending)) {
-		del_timer(&ar->tx_wd_timer);
+		timer_delete(&ar->tx_wd_timer);
 		wake_up(&ar->tx_flush_waitq);
 	}
 
@@ -1076,7 +1076,7 @@ static void ar5523_stop(struct ieee80211_hw *hw, bool suspend)
 
 	ar5523_cmd_write(ar, WDCMSG_TARGET_STOP, NULL, 0, 0);
 
-	del_timer_sync(&ar->tx_wd_timer);
+	timer_delete_sync(&ar->tx_wd_timer);
 	cancel_work_sync(&ar->tx_wd_work);
 	cancel_work_sync(&ar->rx_refill_work);
 	ar5523_cancel_rx_bufs(ar);
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 35bfe72..a0c1afe 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1751,7 +1751,7 @@ void ath10k_debug_stop(struct ath10k *ar)
 
 	/* Must not use _sync to avoid deadlock, we do that in
 	 * ath10k_debug_destroy(). The check for htt_stats_mask is to avoid
-	 * warning from del_timer().
+	 * warning from timer_delete().
 	 */
 	if (ar->debug.htt_stats_mask != 0)
 		cancel_delayed_work(&ar->debug.htt_stats_dwork);
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 7d28ae5..83eab74 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -287,7 +287,7 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	if (htt->ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL)
 		return;
 
-	del_timer_sync(&htt->rx_ring.refill_retry_timer);
+	timer_delete_sync(&htt->rx_ring.refill_retry_timer);
 
 	skb_queue_purge(&htt->rx_msdus_q);
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index c52a16f..fb2c60e 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -619,7 +619,7 @@ static void ath10k_pci_sleep_sync(struct ath10k *ar)
 		return;
 	}
 
-	del_timer_sync(&ar_pci->ps_timer);
+	timer_delete_sync(&ar_pci->ps_timer);
 
 	spin_lock_irqsave(&ar_pci->ps_lock, flags);
 	WARN_ON(ar_pci->ps_wake_refcount > 0);
@@ -1817,7 +1817,7 @@ static void ath10k_pci_rx_retry_sync(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 
-	del_timer_sync(&ar_pci->rx_post_retry);
+	timer_delete_sync(&ar_pci->rx_post_retry);
 }
 
 int ath10k_pci_hif_map_service_to_pipe(struct ath10k *ar, u16 service_id,
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 6805357..7ce74b4 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1621,7 +1621,7 @@ static void ath10k_sdio_hif_power_down(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "sdio power off\n");
 
-	del_timer_sync(&ar_sdio->sleep_timer);
+	timer_delete_sync(&ar_sdio->sleep_timer);
 	ath10k_sdio_set_mbox_sleep(ar, true);
 
 	/* Disable the card */
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index d436a87..866bad2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -911,7 +911,7 @@ static void ath10k_snoc_buffer_cleanup(struct ath10k *ar)
 	struct ath10k_snoc_pipe *pipe_info;
 	int pipe_num;
 
-	del_timer_sync(&ar_snoc->rx_post_retry);
+	timer_delete_sync(&ar_snoc->rx_post_retry);
 	for (pipe_num = 0; pipe_num < CE_COUNT; pipe_num++) {
 		pipe_info = &ar_snoc->pipe_info[pipe_num];
 		ath10k_snoc_rx_pipe_cleanup(pipe_info);
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index eedba37..2f862f8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -397,7 +397,7 @@ static void ath11k_ahb_stop(struct ath11k_base *ab)
 		ath11k_ahb_ce_irqs_disable(ab);
 	ath11k_ahb_sync_ce_irqs(ab);
 	ath11k_ahb_kill_tasklets(ab);
-	del_timer_sync(&ab->rx_replenish_retry);
+	timer_delete_sync(&ab->rx_replenish_retry);
 	ath11k_ce_cleanup_pipes(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f124b73..3a544e5 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -875,7 +875,7 @@ void ath11k_dp_pdev_free(struct ath11k_base *ab)
 	struct ath11k *ar;
 	int i;
 
-	del_timer_sync(&ab->mon_reap_timer);
+	timer_delete_sync(&ab->mon_reap_timer);
 
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
@@ -1170,7 +1170,7 @@ void ath11k_dp_shadow_stop_timer(struct ath11k_base *ab,
 	if (!update_timer->init)
 		return;
 
-	del_timer_sync(&update_timer->timer);
+	timer_delete_sync(&update_timer->timer);
 }
 
 void ath11k_dp_shadow_init_timer(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f2bdbac..218ab41 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -906,7 +906,7 @@ void ath11k_peer_frags_flush(struct ath11k *ar, struct ath11k_peer *peer)
 		rx_tid = &peer->rx_tid[i];
 
 		spin_unlock_bh(&ar->ab->base_lock);
-		del_timer_sync(&rx_tid->frag_timer);
+		timer_delete_sync(&rx_tid->frag_timer);
 		spin_lock_bh(&ar->ab->base_lock);
 
 		ath11k_dp_rx_frags_cleanup(rx_tid, true);
@@ -927,7 +927,7 @@ void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer)
 		ath11k_dp_rx_frags_cleanup(rx_tid, true);
 
 		spin_unlock_bh(&ar->ab->base_lock);
-		del_timer_sync(&rx_tid->frag_timer);
+		timer_delete_sync(&rx_tid->frag_timer);
 		spin_lock_bh(&ar->ab->base_lock);
 	}
 }
@@ -3710,7 +3710,7 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 	}
 
 	spin_unlock_bh(&ab->base_lock);
-	del_timer_sync(&rx_tid->frag_timer);
+	timer_delete_sync(&rx_tid->frag_timer);
 	spin_lock_bh(&ab->base_lock);
 
 	peer = ath11k_peer_find_by_id(ab, peer_id);
@@ -5781,7 +5781,7 @@ int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer)
 	int ret;
 
 	if (stop_timer)
-		del_timer_sync(&ab->mon_reap_timer);
+		timer_delete_sync(&ab->mon_reap_timer);
 
 	/* reap all the monitor related rings */
 	ret = ath11k_dp_purge_mon_ring(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b1f27c3..50c36e6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -985,7 +985,7 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 	if (!ab->mon_reap_timer.function)
 		return;
 
-	del_timer_sync(&ab->mon_reap_timer);
+	timer_delete_sync(&ab->mon_reap_timer);
 
 	for (i = 0; i < ab->num_radios; i++)
 		ath12k_dp_rx_pdev_free(ab, i);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ff6a709..75bf421 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -895,7 +895,7 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer)
 		ath12k_dp_rx_frags_cleanup(rx_tid, true);
 
 		spin_unlock_bh(&ar->ab->base_lock);
-		del_timer_sync(&rx_tid->frag_timer);
+		timer_delete_sync(&rx_tid->frag_timer);
 		spin_lock_bh(&ar->ab->base_lock);
 	}
 }
@@ -3451,7 +3451,7 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 	}
 
 	spin_unlock_bh(&ab->base_lock);
-	del_timer_sync(&rx_tid->frag_timer);
+	timer_delete_sync(&rx_tid->frag_timer);
 	spin_lock_bh(&ab->base_lock);
 
 	peer = ath12k_peer_find_by_id(ab, peer_id);
diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 72ce321..8c2e808 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -149,7 +149,7 @@ static bool __ath6kl_cfg80211_sscan_stop(struct ath6kl_vif *vif)
 	if (!test_and_clear_bit(SCHED_SCANNING, &vif->flags))
 		return false;
 
-	del_timer_sync(&vif->sched_scan_timer);
+	timer_delete_sync(&vif->sched_scan_timer);
 
 	if (ar->state == ATH6KL_STATE_RECOVERY)
 		return true;
@@ -1200,7 +1200,7 @@ static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	if (((vif->auth_mode == WPA_PSK_AUTH) ||
 	     (vif->auth_mode == WPA2_PSK_AUTH)) &&
 	    (key_usage & GROUP_USAGE))
-		del_timer(&vif->disconnect_timer);
+		timer_delete(&vif->disconnect_timer);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG,
 		   "%s: index %d, key_len %d, key_type 0x%x, key_usage 0x%x, seq_len %d\n",
@@ -3612,7 +3612,7 @@ void ath6kl_cfg80211_vif_stop(struct ath6kl_vif *vif, bool wmi_ready)
 		discon_issued = test_bit(CONNECTED, &vif->flags) ||
 				test_bit(CONNECT_PEND, &vif->flags);
 		ath6kl_disconnect(vif);
-		del_timer(&vif->disconnect_timer);
+		timer_delete(&vif->disconnect_timer);
 
 		if (discon_issued)
 			ath6kl_disconnect_event(vif, DISCONNECT_CMD,
diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 15f455a..9b100ee 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1915,7 +1915,7 @@ void ath6kl_stop_txrx(struct ath6kl *ar)
 	clear_bit(WMI_READY, &ar->flag);
 
 	if (ar->fw_recovery.enable)
-		del_timer_sync(&ar->fw_recovery.hb_timer);
+		timer_delete_sync(&ar->fw_recovery.hb_timer);
 
 	/*
 	 * After wmi_shudown all WMI events will be dropped. We
diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 8f9fe23..867089a 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -1027,7 +1027,7 @@ void ath6kl_disconnect_event(struct ath6kl_vif *vif, u8 reason, u8 *bssid,
 
 	aggr_reset_state(vif->aggr_cntxt->aggr_conn);
 
-	del_timer(&vif->disconnect_timer);
+	timer_delete(&vif->disconnect_timer);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "disconnect reason is %d\n", reason);
 
diff --git a/drivers/net/wireless/ath/ath6kl/recovery.c b/drivers/net/wireless/ath/ath6kl/recovery.c
index c09e40c..fd2dceb 100644
--- a/drivers/net/wireless/ath/ath6kl/recovery.c
+++ b/drivers/net/wireless/ath/ath6kl/recovery.c
@@ -25,7 +25,7 @@ static void ath6kl_recovery_work(struct work_struct *work)
 
 	ar->state = ATH6KL_STATE_RECOVERY;
 
-	del_timer_sync(&ar->fw_recovery.hb_timer);
+	timer_delete_sync(&ar->fw_recovery.hb_timer);
 
 	ath6kl_init_hw_restart(ar);
 
@@ -119,7 +119,7 @@ void ath6kl_recovery_cleanup(struct ath6kl *ar)
 
 	set_bit(RECOVERY_CLEANUP, &ar->flag);
 
-	del_timer_sync(&ar->fw_recovery.hb_timer);
+	timer_delete_sync(&ar->fw_recovery.hb_timer);
 	cancel_work_sync(&ar->fw_recovery.recovery_work);
 }
 
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 80e66ac..3a6f0b6 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1827,7 +1827,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		del_timer(&aggr_conn->timer);
+		timer_delete(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index bae24e3..799be0b 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1556,7 +1556,7 @@ void ath9k_p2p_ps_timer(void *priv)
 	struct ath_node *an;
 	u32 tsf;
 
-	del_timer_sync(&sc->sched.timer);
+	timer_delete_sync(&sc->sched.timer);
 	ath9k_hw_gen_timer_stop(sc->sc_ah, sc->p2p_ps_timer);
 	ath_chanctx_event(sc, NULL, ATH_CHANCTX_EVENT_TSF_TIMER);
 
diff --git a/drivers/net/wireless/ath/ath9k/gpio.c b/drivers/net/wireless/ath/ath9k/gpio.c
index b457e52..5a26f1d 100644
--- a/drivers/net/wireless/ath/ath9k/gpio.c
+++ b/drivers/net/wireless/ath/ath9k/gpio.c
@@ -305,7 +305,7 @@ void ath9k_btcoex_timer_resume(struct ath_softc *sc)
 	ath_dbg(ath9k_hw_common(ah), BTCOEX, "Starting btcoex timers\n");
 
 	/* make sure duty cycle timer is also stopped when resuming */
-	del_timer_sync(&btcoex->no_stomp_timer);
+	timer_delete_sync(&btcoex->no_stomp_timer);
 
 	btcoex->bt_priority_cnt = 0;
 	btcoex->bt_priority_time = jiffies;
@@ -329,15 +329,15 @@ void ath9k_btcoex_timer_pause(struct ath_softc *sc)
 
 	ath_dbg(ath9k_hw_common(ah), BTCOEX, "Stopping btcoex timers\n");
 
-	del_timer_sync(&btcoex->period_timer);
-	del_timer_sync(&btcoex->no_stomp_timer);
+	timer_delete_sync(&btcoex->period_timer);
+	timer_delete_sync(&btcoex->no_stomp_timer);
 }
 
 void ath9k_btcoex_stop_gen_timer(struct ath_softc *sc)
 {
 	struct ath_btcoex *btcoex = &sc->btcoex;
 
-	del_timer_sync(&btcoex->no_stomp_timer);
+	timer_delete_sync(&btcoex->no_stomp_timer);
 }
 
 u16 ath9k_btcoex_aggr_limit(struct ath_softc *sc, u32 max_4ms_framelen)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 57094bd..1960001 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -198,7 +198,7 @@ void ath9k_htc_reset(struct ath9k_htc_priv *priv)
 	ath9k_htc_stop_ani(priv);
 	ieee80211_stop_queues(priv->hw);
 
-	del_timer_sync(&priv->tx.cleanup_timer);
+	timer_delete_sync(&priv->tx.cleanup_timer);
 	ath9k_htc_tx_drain(priv);
 
 	WMI_CMD(WMI_DISABLE_INTR_CMDID);
@@ -260,7 +260,7 @@ static int ath9k_htc_set_channel(struct ath9k_htc_priv *priv,
 	ath9k_htc_ps_wakeup(priv);
 
 	ath9k_htc_stop_ani(priv);
-	del_timer_sync(&priv->tx.cleanup_timer);
+	timer_delete_sync(&priv->tx.cleanup_timer);
 	ath9k_htc_tx_drain(priv);
 
 	WMI_CMD(WMI_DISABLE_INTR_CMDID);
@@ -997,7 +997,7 @@ static void ath9k_htc_stop(struct ieee80211_hw *hw, bool suspend)
 
 	tasklet_kill(&priv->rx_tasklet);
 
-	del_timer_sync(&priv->tx.cleanup_timer);
+	timer_delete_sync(&priv->tx.cleanup_timer);
 	ath9k_htc_tx_drain(priv);
 	ath9k_wmi_event_drain(priv);
 
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 01e0dff..ee95149 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -1099,7 +1099,7 @@ static void ath9k_deinit_softc(struct ath_softc *sc)
 		if (ATH_TXQ_SETUP(sc, i))
 			ath_tx_cleanupq(sc, &sc->tx.txq[i]);
 
-	del_timer_sync(&sc->sleep_timer);
+	timer_delete_sync(&sc->sleep_timer);
 	ath9k_hw_deinit(sc->sc_ah);
 	if (sc->dfs_detector != NULL)
 		sc->dfs_detector->exit(sc->dfs_detector);
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index d078a59..7f89099 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -472,7 +472,7 @@ void ath_stop_ani(struct ath_softc *sc)
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 
 	ath_dbg(common, ANI, "Stopping ANI\n");
-	del_timer_sync(&common->ani.timer);
+	timer_delete_sync(&common->ani.timer);
 }
 
 void ath_check_ani(struct ath_softc *sc)
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a70c945..92fc5e3 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -123,7 +123,7 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (++sc->ps_usecount != 1)
 		goto unlock;
 
-	del_timer_sync(&sc->sleep_timer);
+	timer_delete_sync(&sc->sleep_timer);
 	power_mode = sc->sc_ah->power_mode;
 	ath9k_hw_setpower(sc->sc_ah, ATH9K_PM_AWAKE);
 
@@ -2418,7 +2418,7 @@ static void ath9k_cancel_pending_offchannel(struct ath_softc *sc)
 		ath_dbg(common, CHAN_CTX,
 			"%s: Aborting RoC\n", __func__);
 
-		del_timer_sync(&sc->offchannel.timer);
+		timer_delete_sync(&sc->offchannel.timer);
 		if (sc->offchannel.state >= ATH_OFFCHANNEL_ROC_START)
 			ath_roc_complete(sc, ATH_ROC_COMPLETE_ABORT);
 	}
@@ -2427,7 +2427,7 @@ static void ath9k_cancel_pending_offchannel(struct ath_softc *sc)
 		ath_dbg(common, CHAN_CTX,
 			"%s: Aborting HW scan\n", __func__);
 
-		del_timer_sync(&sc->offchannel.timer);
+		timer_delete_sync(&sc->offchannel.timer);
 		ath_scan_complete(sc, true);
 	}
 }
@@ -2476,7 +2476,7 @@ static void ath9k_cancel_hw_scan(struct ieee80211_hw *hw,
 	ath_dbg(common, CHAN_CTX, "Cancel HW scan on vif: %pM\n", vif->addr);
 
 	mutex_lock(&sc->mutex);
-	del_timer_sync(&sc->offchannel.timer);
+	timer_delete_sync(&sc->offchannel.timer);
 	ath_scan_complete(sc, true);
 	mutex_unlock(&sc->mutex);
 }
@@ -2526,7 +2526,7 @@ static int ath9k_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	mutex_lock(&sc->mutex);
 
 	ath_dbg(common, CHAN_CTX, "Cancel RoC\n");
-	del_timer_sync(&sc->offchannel.timer);
+	timer_delete_sync(&sc->offchannel.timer);
 
 	if (sc->offchannel.roc_vif) {
 		if (sc->offchannel.state >= ATH_OFFCHANNEL_ROC_START)
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 1ff5352..27d4034 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -1029,7 +1029,7 @@ static int ath_pci_suspend(struct device *device)
 	 */
 	ath9k_stop_btcoex(sc);
 	ath9k_hw_disable(sc->sc_ah);
-	del_timer_sync(&sc->sleep_timer);
+	timer_delete_sync(&sc->sleep_timer);
 	ath9k_hw_setpower(sc->sc_ah, ATH9K_PM_FULL_SLEEP);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index d405a4c..cc2a033 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -350,7 +350,7 @@ void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status)
 	spin_lock_irqsave(&wcn->dxe_lock, flags);
 	skb = wcn->tx_ack_skb;
 	wcn->tx_ack_skb = NULL;
-	del_timer(&wcn->tx_ack_timer);
+	timer_delete(&wcn->tx_ack_timer);
 	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
 
 	if (!skb) {
@@ -1055,7 +1055,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_delete(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a1a0a92..5473c01 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1017,7 +1017,7 @@ static int wil_cfg80211_scan(struct wiphy *wiphy,
 
 out_restore:
 	if (rc) {
-		del_timer_sync(&vif->scan_timer);
+		timer_delete_sync(&vif->scan_timer);
 		if (vif->mid == 0)
 			wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
 		vif->scan_request = NULL;
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 94e61db..44c24c6 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -798,7 +798,7 @@ void wil6210_disconnect(struct wil6210_vif *vif, const u8 *bssid,
 
 	wil_dbg_misc(wil, "disconnecting\n");
 
-	del_timer_sync(&vif->connect_timer);
+	timer_delete_sync(&vif->connect_timer);
 	_wil6210_disconnect(vif, bssid, reason_code);
 }
 
@@ -818,7 +818,7 @@ void wil6210_disconnect_complete(struct wil6210_vif *vif, const u8 *bssid,
 
 	wil_dbg_misc(wil, "got disconnect\n");
 
-	del_timer_sync(&vif->connect_timer);
+	timer_delete_sync(&vif->connect_timer);
 	_wil6210_disconnect_complete(vif, bssid, reason_code);
 }
 
@@ -1465,7 +1465,7 @@ void wil_abort_scan(struct wil6210_vif *vif, bool sync)
 		return;
 
 	wil_dbg_misc(wil, "Abort scan_request 0x%p\n", vif->scan_request);
-	del_timer_sync(&vif->scan_timer);
+	timer_delete_sync(&vif->scan_timer);
 	mutex_unlock(&wil->vif_mutex);
 	rc = wmi_abort_scan(vif);
 	if (!rc && sync)
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index d5d3646..59884e8 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -200,8 +200,8 @@ static void wil_dev_setup(struct net_device *dev)
 
 static void wil_vif_deinit(struct wil6210_vif *vif)
 {
-	del_timer_sync(&vif->scan_timer);
-	del_timer_sync(&vif->p2p.discovery_timer);
+	timer_delete_sync(&vif->scan_timer);
+	timer_delete_sync(&vif->p2p.discovery_timer);
 	cancel_work_sync(&vif->disconnect_worker);
 	cancel_work_sync(&vif->p2p.discovery_expired_work);
 	cancel_work_sync(&vif->p2p.delayed_listen_work);
@@ -533,7 +533,7 @@ void wil_vif_remove(struct wil6210_priv *wil, u8 mid)
 	mutex_unlock(&wil->vif_mutex);
 
 	flush_work(&wil->wmi_event_worker);
-	del_timer_sync(&vif->connect_timer);
+	timer_delete_sync(&vif->connect_timer);
 	cancel_work_sync(&vif->disconnect_worker);
 	wil_probe_client_flush(vif);
 	cancel_work_sync(&vif->probe_client_worker);
diff --git a/drivers/net/wireless/ath/wil6210/p2p.c b/drivers/net/wireless/ath/wil6210/p2p.c
index f26bf04..f20caf1 100644
--- a/drivers/net/wireless/ath/wil6210/p2p.c
+++ b/drivers/net/wireless/ath/wil6210/p2p.c
@@ -184,7 +184,7 @@ u8 wil_p2p_stop_discovery(struct wil6210_vif *vif)
 			/* discovery not really started, only pending */
 			p2p->pending_listen_wdev = NULL;
 		} else {
-			del_timer_sync(&p2p->discovery_timer);
+			timer_delete_sync(&p2p->discovery_timer);
 			wmi_stop_discovery(vif);
 		}
 		p2p->discovery_started = 0;
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 8ff69dc..74edd00 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -933,7 +933,7 @@ static void wmi_evt_scan_complete(struct wil6210_vif *vif, int id,
 		wil_dbg_wmi(wil, "SCAN_COMPLETE(0x%08x)\n", status);
 		wil_dbg_misc(wil, "Complete scan_request 0x%p aborted %d\n",
 			     vif->scan_request, info.aborted);
-		del_timer_sync(&vif->scan_timer);
+		timer_delete_sync(&vif->scan_timer);
 		cfg80211_scan_done(vif->scan_request, &info);
 		if (vif->mid == 0)
 			wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
@@ -1023,7 +1023,7 @@ static void wmi_evt_connect(struct wil6210_vif *vif, int id, void *d, int len)
 			mutex_unlock(&wil->mutex);
 			return;
 		}
-		del_timer_sync(&vif->connect_timer);
+		timer_delete_sync(&vif->connect_timer);
 	} else if ((wdev->iftype == NL80211_IFTYPE_AP) ||
 		   (wdev->iftype == NL80211_IFTYPE_P2P_GO)) {
 		if (wil->sta[evt->cid].status != wil_sta_unused) {
@@ -1814,7 +1814,7 @@ wmi_evt_reassoc_status(struct wil6210_vif *vif, int id, void *d, int len)
 	wil->sta[cid].stats.ft_roams++;
 	ether_addr_copy(wil->sta[cid].addr, vif->bss->bssid);
 	mutex_unlock(&wil->mutex);
-	del_timer_sync(&vif->connect_timer);
+	timer_delete_sync(&vif->connect_timer);
 
 	cfg80211_ref_bss(wiphy, vif->bss);
 	freq = ieee80211_channel_to_frequency(ch, NL80211_BAND_60GHZ);
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 504e05e..4f01189 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2417,7 +2417,7 @@ static void at76_delete_device(struct at76_priv *priv)
 
 	kfree(priv->bulk_out_buffer);
 
-	del_timer_sync(&ledtrig_tx_timer);
+	timer_delete_sync(&ledtrig_tx_timer);
 
 	kfree_skb(priv->rx_skb);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 1e8495f..e0de34a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -289,7 +289,7 @@ static void brcmf_btcoex_handler(struct work_struct *work)
 	btci = container_of(work, struct brcmf_btcoex_info, work);
 	if (btci->timer_on) {
 		btci->timer_on = false;
-		del_timer_sync(&btci->timer);
+		timer_delete_sync(&btci->timer);
 	}
 
 	switch (btci->bt_state) {
@@ -428,7 +428,7 @@ static void brcmf_btcoex_dhcp_end(struct brcmf_btcoex_info *btci)
 	if (btci->timer_on) {
 		brcmf_dbg(INFO, "disable BT DHCP Timer\n");
 		btci->timer_on = false;
-		del_timer_sync(&btci->timer);
+		timer_delete_sync(&btci->timer);
 
 		/* schedule worker if transition to IDLE is needed */
 		if (btci->bt_state != BRCMF_BT_DHCP_IDLE) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index d2caa80..9f1854b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2304,7 +2304,7 @@ brcmf_pcie_fwcon_timer(struct brcmf_pciedev_info *devinfo, bool active)
 {
 	if (!active) {
 		if (devinfo->console_active) {
-			del_timer_sync(&devinfo->timer);
+			timer_delete_sync(&devinfo->timer);
 			devinfo->console_active = false;
 		}
 		return;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b1727f3..93727b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4611,7 +4611,7 @@ void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active)
 {
 	/* Totally stop the timer */
 	if (!active && bus->wd_active) {
-		del_timer_sync(&bus->timer);
+		timer_delete_sync(&bus->timer);
 		bus->wd_active = false;
 		return;
 	}
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
index 32639e0..dfcc12a 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
@@ -59,7 +59,7 @@ void libipw_crypt_info_free(struct libipw_crypt_info *info)
 	int i;
 
         libipw_crypt_quiescing(info);
-        del_timer_sync(&info->crypt_deinit_timer);
+        timer_delete_sync(&info->crypt_deinit_timer);
         libipw_crypt_deinit_entries(info, 1);
 
         for (i = 0; i < NUM_WEP_KEYS; i++) {
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 4013443..104748f 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -2188,7 +2188,7 @@ __il3945_down(struct il_priv *il)
 
 	/* Stop TX queues watchdog. We need to have S_EXIT_PENDING bit set
 	 * to prevent rearm timer */
-	del_timer_sync(&il->watchdog);
+	timer_delete_sync(&il->watchdog);
 
 	/* Station information will now be cleared in device */
 	il_clear_ucode_stations(il);
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 0eaad98..df1b8ec 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -413,7 +413,7 @@ il3945_rs_free_sta(void *il_priv, struct ieee80211_sta *sta, void *il_sta)
 	 * to use il_priv to print out debugging) since it may not be fully
 	 * initialized at this point.
 	 */
-	del_timer_sync(&rs_sta->rate_scale_flush);
+	timer_delete_sync(&rs_sta->rate_scale_flush);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 05c4af4..dc8c408 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -5350,7 +5350,7 @@ __il4965_down(struct il_priv *il)
 
 	/* Stop TX queues watchdog. We need to have S_EXIT_PENDING bit set
 	 * to prevent rearm timer */
-	del_timer_sync(&il->watchdog);
+	timer_delete_sync(&il->watchdog);
 
 	il_clear_ucode_stations(il);
 
@@ -6243,7 +6243,7 @@ il4965_cancel_deferred_work(struct il_priv *il)
 
 	il_cancel_scan_deferred_work(il);
 
-	del_timer_sync(&il->stats_periodic);
+	timer_delete_sync(&il->stats_periodic);
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index af4f425..09fb4b7 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4842,7 +4842,7 @@ il_setup_watchdog(struct il_priv *il)
 		mod_timer(&il->watchdog,
 			  jiffies + msecs_to_jiffies(IL_WD_TICK(timeout)));
 	else
-		del_timer(&il->watchdog);
+		timer_delete(&il->watchdog);
 }
 EXPORT_SYMBOL(il_setup_watchdog);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index b246dbd..2ed4b6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -1870,7 +1870,7 @@ static ssize_t iwl_dbgfs_ucode_tracing_write(struct file *file,
 		}
 	} else {
 		priv->event_log.ucode_trace = false;
-		del_timer_sync(&priv->ucode_trace);
+		timer_delete_sync(&priv->ucode_trace);
 	}
 
 	return count;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 30789ba..a27a72c 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1082,8 +1082,8 @@ void iwl_cancel_deferred_work(struct iwl_priv *priv)
 	cancel_work_sync(&priv->bt_full_concurrency);
 	cancel_work_sync(&priv->bt_runtime_config);
 
-	del_timer_sync(&priv->statistics_periodic);
-	del_timer_sync(&priv->ucode_trace);
+	timer_delete_sync(&priv->statistics_periodic);
+	timer_delete_sync(&priv->ucode_trace);
 }
 
 static int iwl_init_drv(struct iwl_priv *priv)
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
index e1d7855..98f0949 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
@@ -257,7 +257,7 @@ static void iwl_legacy_tt_handler(struct iwl_priv *priv, s32 temp, bool force)
 	tt->tt_previous_temp = temp;
 #endif
 	/* stop ct_kill_waiting_tm timer */
-	del_timer_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
+	timer_delete_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
 	if (tt->state != old_state) {
 		switch (tt->state) {
 		case IWL_TI_0:
@@ -378,7 +378,7 @@ static void iwl_advance_tt_handler(struct iwl_priv *priv, s32 temp, bool force)
 		}
 	}
 	/* stop ct_kill_waiting_tm timer */
-	del_timer_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
+	timer_delete_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
 	if (changed) {
 		if (tt->state >= IWL_TI_1) {
 			/* force PI = IWL_POWER_INDEX_5 in the case of TI > 0 */
@@ -506,7 +506,7 @@ static void iwl_bg_ct_exit(struct work_struct *work)
 		return;
 
 	/* stop ct_kill_exit_tm timer */
-	del_timer_sync(&priv->thermal_throttle.ct_kill_exit_tm);
+	timer_delete_sync(&priv->thermal_throttle.ct_kill_exit_tm);
 
 	if (tt->state == IWL_TI_CT_KILL) {
 		IWL_ERR(priv,
@@ -640,9 +640,9 @@ void iwl_tt_exit(struct iwl_priv *priv)
 	struct iwl_tt_mgmt *tt = &priv->thermal_throttle;
 
 	/* stop ct_kill_exit_tm timer if activated */
-	del_timer_sync(&priv->thermal_throttle.ct_kill_exit_tm);
+	timer_delete_sync(&priv->thermal_throttle.ct_kill_exit_tm);
 	/* stop ct_kill_waiting_tm timer if activated */
-	del_timer_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
+	timer_delete_sync(&priv->thermal_throttle.ct_kill_waiting_tm);
 	cancel_work_sync(&priv->tt_work);
 	cancel_work_sync(&priv->ct_enter);
 	cancel_work_sync(&priv->ct_exit);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4a442d0..4a4f8de 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1697,7 +1697,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
 		if (!trans_pcie->txqs.txq[i])
 			continue;
-		del_timer(&trans_pcie->txqs.txq[i]->stuck_timer);
+		timer_delete(&trans_pcie->txqs.txq[i]->stuck_timer);
 	}
 
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 401919f..71227fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -911,7 +911,7 @@ static void iwl_txq_gen2_free(struct iwl_trans *trans, int txq_id)
 			kfree_sensitive(txq->entries[i].cmd);
 			kfree_sensitive(txq->entries[i].free_buf);
 		}
-	del_timer_sync(&txq->stuck_timer);
+	timer_delete_sync(&txq->stuck_timer);
 
 	iwl_txq_gen2_free_memory(trans, txq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7c1dd5c..bb90bcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -469,7 +469,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	kfree(txq->entries);
 	txq->entries = NULL;
 
-	del_timer_sync(&txq->stuck_timer);
+	timer_delete_sync(&txq->stuck_timer);
 
 	/* 0-fill queue descriptor structure */
 	memset(txq, 0, sizeof(*txq));
@@ -1054,7 +1054,7 @@ static void iwl_txq_progress(struct iwl_txq *txq)
 	 * since we're making progress on this queue
 	 */
 	if (txq->read_ptr == txq->write_ptr)
-		del_timer(&txq->stuck_timer);
+		timer_delete(&txq->stuck_timer);
 	else
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 }
@@ -2529,7 +2529,7 @@ void iwl_pcie_freeze_txq_timer(struct iwl_trans *trans,
 			/* remember how long until the timer fires */
 			txq->frozen_expiry_remainder =
 				txq->stuck_timer.expires - now;
-			del_timer(&txq->stuck_timer);
+			timer_delete(&txq->stuck_timer);
 			goto next_queue;
 		}
 
diff --git a/drivers/net/wireless/marvell/libertas/cmdresp.c b/drivers/net/wireless/marvell/libertas/cmdresp.c
index 8393f39..9742d3d 100644
--- a/drivers/net/wireless/marvell/libertas/cmdresp.c
+++ b/drivers/net/wireless/marvell/libertas/cmdresp.c
@@ -119,7 +119,7 @@ int lbs_process_command_response(struct lbs_private *priv, u8 *data, u32 len)
 	}
 
 	/* Now we got response from FW, cancel the command timer */
-	del_timer(&priv->command_timer);
+	timer_delete(&priv->command_timer);
 	priv->cmd_timed_out = 0;
 
 	if (respcmd == CMD_RET(CMD_802_11_PS_MODE)) {
diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 2240b4d..ea3cc2e 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -897,7 +897,7 @@ restart:
 	/* ... and wait for the process to complete */
 	wait_event_interruptible(cardp->fw_wq, cardp->surprise_removed || cardp->fwdnldover);
 
-	del_timer_sync(&cardp->fw_timeout);
+	timer_delete_sync(&cardp->fw_timeout);
 	usb_kill_urb(cardp->rx_urb);
 
 	if (!cardp->fwdnldover) {
diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 017e5c6..26d13e9 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -202,7 +202,7 @@ int lbs_stop_iface(struct lbs_private *priv)
 	spin_unlock_irqrestore(&priv->driver_lock, flags);
 
 	cancel_work_sync(&priv->mcast_work);
-	del_timer_sync(&priv->tx_lockup_timer);
+	timer_delete_sync(&priv->tx_lockup_timer);
 
 	/* Disable command processing, and wait for all commands to complete */
 	lbs_deb_main("waiting for commands to complete\n");
@@ -250,7 +250,7 @@ void lbs_host_to_card_done(struct lbs_private *priv)
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->driver_lock, flags);
-	del_timer(&priv->tx_lockup_timer);
+	timer_delete(&priv->tx_lockup_timer);
 
 	priv->dnld_sent = DNLD_RES_RECEIVED;
 
@@ -594,8 +594,8 @@ static int lbs_thread(void *data)
 		spin_unlock_irq(&priv->driver_lock);
 	}
 
-	del_timer(&priv->command_timer);
-	del_timer(&priv->tx_lockup_timer);
+	timer_delete(&priv->command_timer);
+	timer_delete(&priv->tx_lockup_timer);
 
 	return 0;
 }
@@ -798,8 +798,8 @@ static void lbs_free_adapter(struct lbs_private *priv)
 {
 	lbs_free_cmd_buffer(priv);
 	kfifo_free(&priv->event_fifo);
-	del_timer(&priv->command_timer);
-	del_timer(&priv->tx_lockup_timer);
+	timer_delete(&priv->command_timer);
+	timer_delete(&priv->tx_lockup_timer);
 }
 
 static const struct net_device_ops lbs_netdev_ops = {
diff --git a/drivers/net/wireless/marvell/libertas_tf/cmd.c b/drivers/net/wireless/marvell/libertas_tf/cmd.c
index efb9830..7fc1bdb 100644
--- a/drivers/net/wireless/marvell/libertas_tf/cmd.c
+++ b/drivers/net/wireless/marvell/libertas_tf/cmd.c
@@ -757,7 +757,7 @@ int lbtf_process_rx_command(struct lbtf_private *priv)
 	}
 
 	/* Now we got response from FW, cancel the command timer */
-	del_timer(&priv->command_timer);
+	timer_delete(&priv->command_timer);
 	priv->cmd_timed_out = 0;
 	if (priv->nr_retries)
 		priv->nr_retries = 0;
diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index 1750f5e..7c413dc 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -875,7 +875,7 @@ restart:
 	wait_event_interruptible(cardp->fw_wq, cardp->priv->surpriseremoved ||
 					       cardp->fwdnldover);
 
-	del_timer_sync(&cardp->fw_timeout);
+	timer_delete_sync(&cardp->fw_timeout);
 	usb_kill_urb(cardp->rx_urb);
 
 	if (!cardp->fwdnldover) {
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index b47a832..a57a11b 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	del_timer(&priv->command_timer);
+	timer_delete(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
@@ -642,7 +642,7 @@ int lbtf_remove_card(struct lbtf_private *priv)
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 
 	priv->surpriseremoved = 1;
-	del_timer(&priv->command_timer);
+	timer_delete(&priv->command_timer);
 	lbtf_free_adapter(priv);
 	priv->hw = NULL;
 	ieee80211_unregister_hw(hw);
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index cb948ca..8aff1df 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -206,7 +206,7 @@ mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 	start_win = (tbl->start_win + tbl->win_size) & (MAX_TID_VALUE - 1);
 	mwifiex_11n_dispatch_pkt_until_start_win(priv, tbl, start_win);
 
-	del_timer_sync(&tbl->timer_context.timer);
+	timer_delete_sync(&tbl->timer_context.timer);
 	tbl->timer_context.timer_is_set = false;
 
 	spin_lock_bh(&priv->rx_reorder_tbl_lock);
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index b30ed32..5573e2d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -836,7 +836,7 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 		return -1;
 	}
 	/* Now we got response from FW, cancel the command timer */
-	del_timer_sync(&adapter->cmd_timer);
+	timer_delete_sync(&adapter->cmd_timer);
 	clear_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags);
 
 	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 8b61e45..ce0d42e 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -390,7 +390,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
 static void
 mwifiex_adapter_cleanup(struct mwifiex_adapter *adapter)
 {
-	del_timer(&adapter->wakeup_timer);
+	timer_delete(&adapter->wakeup_timer);
 	cancel_delayed_work_sync(&adapter->devdump_work);
 	mwifiex_cancel_all_pending_cmd(adapter);
 	wake_up_interruptible(&adapter->cmd_wait_q.wait);
@@ -613,7 +613,7 @@ mwifiex_shutdown_drv(struct mwifiex_adapter *adapter)
 	if (adapter->curr_cmd) {
 		mwifiex_dbg(adapter, WARN,
 			    "curr_cmd is still in processing\n");
-		del_timer_sync(&adapter->cmd_timer);
+		timer_delete_sync(&adapter->cmd_timer);
 		mwifiex_recycle_cmd_node(adapter, adapter->curr_cmd);
 		adapter->curr_cmd = NULL;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index b07cb30..0e1f539 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -307,7 +307,7 @@ process_start:
 		if (IS_CARD_RX_RCVD(adapter)) {
 			adapter->data_received = false;
 			adapter->pm_wakeup_fw_try = false;
-			del_timer(&adapter->wakeup_timer);
+			timer_delete(&adapter->wakeup_timer);
 			if (adapter->ps_state == PS_STATE_SLEEP)
 				adapter->ps_state = PS_STATE_AWAKE;
 		} else {
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index e11458f..dd2a42e 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2437,7 +2437,7 @@ static void mwifiex_interrupt_status(struct mwifiex_adapter *adapter,
 		 */
 		adapter->ps_state = PS_STATE_AWAKE;
 		adapter->pm_wakeup_fw_try = false;
-		del_timer(&adapter->wakeup_timer);
+		timer_delete(&adapter->wakeup_timer);
 	}
 
 	spin_lock_irqsave(&adapter->int_lock, flags);
@@ -2527,7 +2527,7 @@ static int mwifiex_process_int_status(struct mwifiex_adapter *adapter)
 				    adapter->ps_state == PS_STATE_SLEEP) {
 					adapter->ps_state = PS_STATE_AWAKE;
 					adapter->pm_wakeup_fw_try = false;
-					del_timer(&adapter->wakeup_timer);
+					timer_delete(&adapter->wakeup_timer);
 				}
 			}
 		}
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 400348a..fecd889 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -789,7 +789,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 					adapter->ps_state = PS_STATE_AWAKE;
 					adapter->pm_wakeup_card_req = false;
 					adapter->pm_wakeup_fw_try = false;
-					del_timer(&adapter->wakeup_timer);
+					timer_delete(&adapter->wakeup_timer);
 					break;
 				}
 				if (!mwifiex_send_null_packet
@@ -804,7 +804,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		adapter->ps_state = PS_STATE_AWAKE;
 		adapter->pm_wakeup_card_req = false;
 		adapter->pm_wakeup_fw_try = false;
-		del_timer(&adapter->wakeup_timer);
+		timer_delete(&adapter->wakeup_timer);
 
 		break;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 0a5f340..18e8c04 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -1490,7 +1490,7 @@ void mwifiex_clean_auto_tdls(struct mwifiex_private *priv)
 	    priv->adapter->auto_tdls &&
 	    priv->bss_type == MWIFIEX_BSS_TYPE_STA) {
 		priv->auto_tdls_timer_active = false;
-		del_timer(&priv->auto_tdls_timer);
+		timer_delete(&priv->auto_tdls_timer);
 		mwifiex_flush_auto_tdls_list(priv);
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 3034c44..2f56539 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -877,7 +877,7 @@ static int mwifiex_usb_prepare_tx_aggr_skb(struct mwifiex_adapter *adapter,
 	 * write complete, delete the tx_aggr timer
 	 */
 	if (port->tx_aggr.timer_cnxt.is_hold_timer_set) {
-		del_timer(&port->tx_aggr.timer_cnxt.hold_timer);
+		timer_delete(&port->tx_aggr.timer_cnxt.hold_timer);
 		port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
 		port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
 	}
@@ -1354,7 +1354,7 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
 				mwifiex_write_data_complete(adapter, skb_tmp,
 							    0, -1);
 		if (port->tx_aggr.timer_cnxt.hold_timer.function)
-			del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
+			timer_delete_sync(&port->tx_aggr.timer_cnxt.hold_timer);
 		port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
 		port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
 	}
@@ -1557,7 +1557,7 @@ static int mwifiex_pm_wakeup_card(struct mwifiex_adapter *adapter)
 {
 	/* Simulation of HS_AWAKE event */
 	adapter->pm_wakeup_fw_try = false;
-	del_timer(&adapter->wakeup_timer);
+	timer_delete(&adapter->wakeup_timer);
 	adapter->pm_wakeup_card_req = false;
 	adapter->ps_state = PS_STATE_AWAKE;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2e7b05e..c54005d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -97,7 +97,7 @@ static void mt7615_stop(struct ieee80211_hw *hw, bool suspend)
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
@@ -1194,7 +1194,7 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt7615_mutex_acquire(phy->dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index c2e4e6a..b795d11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -220,12 +220,12 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	del_timer_sync(&dev->phy.roc_timer);
+	timer_delete_sync(&dev->phy.roc_timer);
 	cancel_work_sync(&dev->phy.roc_work);
 	if (phy2) {
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-		del_timer_sync(&phy2->roc_timer);
+		timer_delete_sync(&phy2->roc_timer);
 		cancel_work_sync(&phy2->roc_work);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 4aa9fa1..d96e06b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -85,7 +85,7 @@ static void mt7663u_stop(struct ieee80211_hw *hw, bool suspend)
 	struct mt7615_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 78b77a5..826c48a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -364,7 +364,7 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
@@ -395,7 +395,7 @@ static int mt7921_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 {
 	int err = 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt792x_mutex_acquire(phy->dev);
@@ -1476,7 +1476,7 @@ static void mt7921_abort_channel_switch(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-	del_timer_sync(&mvif->csa_timer);
+	timer_delete_sync(&mvif->csa_timer);
 	cancel_work_sync(&mvif->csa_work);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index e79364a..66f3277 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -453,7 +453,7 @@ void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
@@ -485,7 +485,7 @@ static int mt7925_abort_roc(struct mt792x_phy *phy,
 {
 	int err = 0;
 
-	del_timer_sync(&phy->roc_timer);
+	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
 	mt792x_mutex_acquire(phy->dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 0f7806f..38dd58f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -340,7 +340,7 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (vif->bss_conf.csa_active) {
-		del_timer_sync(&mvif->csa_timer);
+		timer_delete_sync(&mvif->csa_timer);
 		cancel_work_sync(&mvif->csa_work);
 	}
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index bba5330..cb46a39 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -643,7 +643,7 @@ static inline void host_int_parse_assoc_resp_info(struct wilc_vif *vif,
 		}
 	}
 
-	del_timer(&hif_drv->connect_timer);
+	timer_delete(&hif_drv->connect_timer);
 	conn_info->conn_result(CONN_DISCONN_EVENT_CONN_RESP, mac_status,
 			       hif_drv->conn_info.priv);
 
@@ -669,7 +669,7 @@ void wilc_handle_disconnect(struct wilc_vif *vif)
 	struct host_if_drv *hif_drv = vif->hif_drv;
 
 	if (hif_drv->usr_scan_req.scan_result) {
-		del_timer(&hif_drv->scan_timer);
+		timer_delete(&hif_drv->scan_timer);
 		handle_scan_done(vif, SCAN_EVENT_ABORTED);
 	}
 
@@ -713,7 +713,7 @@ static void handle_rcvd_gnrl_async_info(struct work_struct *work)
 		if (hif_drv->hif_state == HOST_IF_CONNECTED) {
 			wilc_handle_disconnect(vif);
 		} else if (hif_drv->usr_scan_req.scan_result) {
-			del_timer(&hif_drv->scan_timer);
+			timer_delete(&hif_drv->scan_timer);
 			handle_scan_done(vif, SCAN_EVENT_ABORTED);
 		}
 	}
@@ -746,7 +746,7 @@ int wilc_disconnect(struct wilc_vif *vif)
 	conn_info = &hif_drv->conn_info;
 
 	if (scan_req->scan_result) {
-		del_timer(&hif_drv->scan_timer);
+		timer_delete(&hif_drv->scan_timer);
 		scan_req->scan_result(SCAN_EVENT_ABORTED, NULL, scan_req->priv);
 		scan_req->scan_result = NULL;
 	}
@@ -754,7 +754,7 @@ int wilc_disconnect(struct wilc_vif *vif)
 	if (conn_info->conn_result) {
 		if (hif_drv->hif_state == HOST_IF_WAITING_CONN_RESP ||
 		    hif_drv->hif_state == HOST_IF_EXTERNAL_AUTH)
-			del_timer(&hif_drv->connect_timer);
+			timer_delete(&hif_drv->connect_timer);
 
 		conn_info->conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF, 0,
 				       conn_info->priv);
@@ -959,7 +959,7 @@ static void listen_timer_cb(struct timer_list *t)
 	int result;
 	struct host_if_msg *msg;
 
-	del_timer(&vif->hif_drv->remain_on_ch_timer);
+	timer_delete(&vif->hif_drv->remain_on_ch_timer);
 
 	msg = wilc_alloc_work(vif, wilc_handle_listen_state_expired, false);
 	if (IS_ERR(msg))
@@ -1066,7 +1066,7 @@ static void handle_scan_complete(struct work_struct *work)
 {
 	struct host_if_msg *msg = container_of(work, struct host_if_msg, work);
 
-	del_timer(&msg->vif->hif_drv->scan_timer);
+	timer_delete(&msg->vif->hif_drv->scan_timer);
 
 	handle_scan_done(msg->vif, SCAN_EVENT_DONE);
 
@@ -1551,7 +1551,7 @@ int wilc_deinit(struct wilc_vif *vif)
 
 	timer_shutdown_sync(&hif_drv->scan_timer);
 	timer_shutdown_sync(&hif_drv->connect_timer);
-	del_timer_sync(&vif->periodic_rssi);
+	timer_delete_sync(&vif->periodic_rssi);
 	timer_shutdown_sync(&hif_drv->remain_on_ch_timer);
 
 	if (hif_drv->usr_scan_req.scan_result) {
@@ -1718,7 +1718,7 @@ int wilc_listen_state_expired(struct wilc_vif *vif, u64 cookie)
 		return -EFAULT;
 	}
 
-	del_timer(&vif->hif_drv->remain_on_ch_timer);
+	timer_delete(&vif->hif_drv->remain_on_ch_timer);
 
 	return wilc_handle_roc_expired(vif, cookie);
 }
diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 56d1139..10d2e21 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -714,8 +714,8 @@ static void disconnect(struct usb_interface *intf)
 	mac = plfxlc_hw_mac(hw);
 	usb = &mac->chip.usb;
 
-	del_timer_sync(&usb->tx.tx_retry_timer);
-	del_timer_sync(&usb->sta_queue_cleanup);
+	timer_delete_sync(&usb->tx.tx_retry_timer);
+	timer_delete_sync(&usb->sta_queue_cleanup);
 
 	ieee80211_unregister_hw(hw);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index ff61867..6189edc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -473,7 +473,7 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	del_timer_sync(&rtlpriv->works.watchdog_timer);
+	timer_delete_sync(&rtlpriv->works.watchdog_timer);
 
 	cancel_delayed_work_sync(&rtlpriv->works.watchdog_wq);
 	if (ips_wq)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index 35875cd..2ad4523 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -179,9 +179,9 @@ static void rtl88e_deinit_sw_vars(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->psc.low_power_enable)
-		del_timer_sync(&rtlpriv->works.fw_clockoff_timer);
+		timer_delete_sync(&rtlpriv->works.fw_clockoff_timer);
 
-	del_timer_sync(&rtlpriv->works.fast_antenna_training_timer);
+	timer_delete_sync(&rtlpriv->works.fast_antenna_training_timer);
 }
 
 /* get bt coexist status */
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 2cebe56..5382765 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -493,7 +493,7 @@ static void bl_cmd_timeout(struct timer_list *t)
 	struct rsi_hw *adapter = from_timer(adapter, t, bl_cmd_timer);
 
 	adapter->blcmd_timer_expired = true;
-	del_timer(&adapter->bl_cmd_timer);
+	timer_delete(&adapter->bl_cmd_timer);
 }
 
 static int bl_start_cmd_timer(struct rsi_hw *adapter, u32 timeout)
@@ -511,7 +511,7 @@ static int bl_stop_cmd_timer(struct rsi_hw *adapter)
 {
 	adapter->blcmd_timer_expired = false;
 	if (timer_pending(&adapter->bl_cmd_timer))
-		del_timer(&adapter->bl_cmd_timer);
+		timer_delete(&adapter->bl_cmd_timer);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 3425a47..9db0820 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1754,7 +1754,7 @@ void rsi_roc_timeout(struct timer_list *t)
 	ieee80211_remain_on_channel_expired(common->priv->hw);
 
 	if (timer_pending(&common->roc_timer))
-		del_timer(&common->roc_timer);
+		timer_delete(&common->roc_timer);
 
 	rsi_resume_conn_channel(common);
 	mutex_unlock(&common->mutex);
@@ -1776,7 +1776,7 @@ static int rsi_mac80211_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (timer_pending(&common->roc_timer)) {
 		rsi_dbg(INFO_ZONE, "Stop on-going ROC\n");
-		del_timer(&common->roc_timer);
+		timer_delete(&common->roc_timer);
 	}
 	common->roc_timer.expires = msecs_to_jiffies(duration) + jiffies;
 	add_timer(&common->roc_timer);
@@ -1820,7 +1820,7 @@ static int rsi_mac80211_cancel_roc(struct ieee80211_hw *hw,
 		return 0;
 	}
 
-	del_timer(&common->roc_timer);
+	timer_delete(&common->roc_timer);
 
 	rsi_resume_conn_channel(common);
 	mutex_unlock(&common->mutex);
diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
index a54a7b8..5d569ee 100644
--- a/drivers/net/wireless/st/cw1200/main.c
+++ b/drivers/net/wireless/st/cw1200/main.c
@@ -458,7 +458,7 @@ static void cw1200_unregister_common(struct ieee80211_hw *dev)
 
 	ieee80211_unregister_hw(dev);
 
-	del_timer_sync(&priv->mcast_timeout);
+	timer_delete_sync(&priv->mcast_timeout);
 	cw1200_unregister_bh(priv);
 
 	cw1200_debug_release(priv);
diff --git a/drivers/net/wireless/st/cw1200/pm.c b/drivers/net/wireless/st/cw1200/pm.c
index a20ab57..2002e3f 100644
--- a/drivers/net/wireless/st/cw1200/pm.c
+++ b/drivers/net/wireless/st/cw1200/pm.c
@@ -105,7 +105,7 @@ int cw1200_pm_init(struct cw1200_pm_state *pm,
 
 void cw1200_pm_deinit(struct cw1200_pm_state *pm)
 {
-	del_timer_sync(&pm->stay_awake);
+	timer_delete_sync(&pm->stay_awake);
 }
 
 void cw1200_pm_stay_awake(struct cw1200_pm_state *pm,
diff --git a/drivers/net/wireless/st/cw1200/queue.c b/drivers/net/wireless/st/cw1200/queue.c
index 259739e..4fd7618 100644
--- a/drivers/net/wireless/st/cw1200/queue.c
+++ b/drivers/net/wireless/st/cw1200/queue.c
@@ -244,7 +244,7 @@ void cw1200_queue_stats_deinit(struct cw1200_queue_stats *stats)
 void cw1200_queue_deinit(struct cw1200_queue *queue)
 {
 	cw1200_queue_clear(queue);
-	del_timer_sync(&queue->gc);
+	timer_delete_sync(&queue->gc);
 	INIT_LIST_HEAD(&queue->free_pool);
 	kfree(queue->pool);
 	kfree(queue->link_map_cache);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index c259da8..444272c 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -113,7 +113,7 @@ void cw1200_stop(struct ieee80211_hw *dev, bool suspend)
 	cancel_work_sync(&priv->unjoin_work);
 	cancel_delayed_work_sync(&priv->link_id_gc_work);
 	flush_workqueue(priv->workqueue);
-	del_timer_sync(&priv->mcast_timeout);
+	timer_delete_sync(&priv->mcast_timeout);
 	mutex_lock(&priv->conf_mutex);
 	priv->mode = NL80211_IFTYPE_UNSPECIFIED;
 	priv->listening = false;
@@ -2102,7 +2102,7 @@ void cw1200_multicast_stop_work(struct work_struct *work)
 		container_of(work, struct cw1200_common, multicast_stop_work);
 
 	if (priv->aid0_bit_set) {
-		del_timer_sync(&priv->mcast_timeout);
+		timer_delete_sync(&priv->mcast_timeout);
 		wsm_lock_tx(priv);
 		priv->aid0_bit_set = false;
 		cw1200_set_tim_impl(priv, false);
@@ -2170,7 +2170,7 @@ void cw1200_suspend_resume(struct cw1200_common *priv,
 		}
 		spin_unlock_bh(&priv->ps_state_lock);
 		if (cancel_tmo)
-			del_timer_sync(&priv->mcast_timeout);
+			timer_delete_sync(&priv->mcast_timeout);
 	} else {
 		spin_lock_bh(&priv->ps_state_lock);
 		cw1200_ps_notify(priv, arg->link_id, arg->stop);
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 8fb58a5..ea9bc47 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -117,7 +117,7 @@ int wl1271_recalc_rx_streaming(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	else {
 		ret = wl1271_set_rx_streaming(wl, wlvif, false);
 		/* don't cancel_work_sync since we might deadlock */
-		del_timer_sync(&wlvif->rx_streaming_timer);
+		timer_delete_sync(&wlvif->rx_streaming_timer);
 	}
 out:
 	return ret;
@@ -2841,7 +2841,7 @@ deinit:
 unlock:
 	mutex_unlock(&wl->mutex);
 
-	del_timer_sync(&wlvif->rx_streaming_timer);
+	timer_delete_sync(&wlvif->rx_streaming_timer);
 	cancel_work_sync(&wlvif->rx_streaming_enable_work);
 	cancel_work_sync(&wlvif->rx_streaming_disable_work);
 	cancel_work_sync(&wlvif->rc_update_work);
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 325fcb3..a0a4388 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -329,7 +329,7 @@ static void xenvif_down(struct xenvif *vif)
 		if (queue->tx_irq != queue->rx_irq)
 			disable_irq(queue->rx_irq);
 		napi_disable(&queue->napi);
-		del_timer_sync(&queue->credit_timeout);
+		timer_delete_sync(&queue->credit_timeout);
 	}
 }
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 63fe51d..fc52d5c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1819,7 +1819,7 @@ static void xennet_disconnect_backend(struct netfront_info *info)
 	for (i = 0; i < num_queues && info->queues; ++i) {
 		struct netfront_queue *queue = &info->queues[i];
 
-		del_timer_sync(&queue->rx_refill_timer);
+		timer_delete_sync(&queue->rx_refill_timer);
 
 		if (queue->tx_irq && (queue->tx_irq == queue->rx_irq))
 			unbind_from_irqhandler(queue->tx_irq, queue);
diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index 9309441..43ce0c9 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -102,10 +102,10 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
 	atomic_set(&priv->ndev->cmd_cnt, 0);
 
 	if (timer_pending(&priv->ndev->cmd_timer))
-		del_timer_sync(&priv->ndev->cmd_timer);
+		timer_delete_sync(&priv->ndev->cmd_timer);
 
 	if (timer_pending(&priv->fw_dnld.timer))
-		del_timer_sync(&priv->fw_dnld.timer);
+		timer_delete_sync(&priv->fw_dnld.timer);
 
 	nfc_info(priv->dev, "FW loading over (%d)]\n", error);
 
@@ -464,7 +464,7 @@ void nfcmrvl_fw_dnld_recv_frame(struct nfcmrvl_private *priv,
 {
 	/* Discard command timer */
 	if (timer_pending(&priv->ndev->cmd_timer))
-		del_timer_sync(&priv->ndev->cmd_timer);
+		timer_delete_sync(&priv->ndev->cmd_timer);
 
 	/* Allow next command */
 	atomic_set(&priv->ndev->cmd_cnt, 1);
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index e2bc673..34c40d1 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1515,7 +1515,7 @@ static int pn533_poll_complete(struct pn533 *dev, void *arg,
 	cur_mod = dev->poll_mod_active[dev->poll_mod_curr];
 
 	if (cur_mod->len == 0) { /* Target mode */
-		del_timer(&dev->listen_timer);
+		timer_delete(&dev->listen_timer);
 		rc = pn533_init_target_complete(dev, resp);
 		goto done;
 	}
@@ -1749,7 +1749,7 @@ static void pn533_stop_poll(struct nfc_dev *nfc_dev)
 {
 	struct pn533 *dev = nfc_get_drvdata(nfc_dev);
 
-	del_timer(&dev->listen_timer);
+	timer_delete(&dev->listen_timer);
 
 	if (!dev->poll_mod_count) {
 		dev_dbg(dev->dev,
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index cfbbe07..580c919 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -209,7 +209,7 @@ static size_t pn532_receive_buf(struct serdev_device *serdev,
 	struct pn532_uart_phy *dev = serdev_device_get_drvdata(serdev);
 	size_t i;
 
-	del_timer(&dev->cmd_timeout);
+	timer_delete(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
 		skb_put_u8(dev->recv_skb, *data++);
 		if (!pn532_uart_rx_is_frame(dev->recv_skb))
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index d2aa9f7..8feac11 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -161,8 +161,8 @@ static void llt_ndlc_rcv_queue(struct llt_ndlc *ndlc)
 			case PCB_SYNC_ACK:
 				skb = skb_dequeue(&ndlc->ack_pending_q);
 				kfree_skb(skb);
-				del_timer_sync(&ndlc->t1_timer);
-				del_timer_sync(&ndlc->t2_timer);
+				timer_delete_sync(&ndlc->t1_timer);
+				timer_delete_sync(&ndlc->t2_timer);
 				ndlc->t2_active = false;
 				ndlc->t1_active = false;
 				break;
@@ -213,8 +213,8 @@ static void llt_ndlc_sm_work(struct work_struct *work)
 		pr_debug("Handle T2(recv DATA) elapsed (T2 now inactive)\n");
 		ndlc->t2_active = false;
 		ndlc->t1_active = false;
-		del_timer_sync(&ndlc->t1_timer);
-		del_timer_sync(&ndlc->t2_timer);
+		timer_delete_sync(&ndlc->t1_timer);
+		timer_delete_sync(&ndlc->t2_timer);
 		ndlc_close(ndlc);
 		ndlc->hard_fault = -EREMOTEIO;
 	}
@@ -283,8 +283,8 @@ EXPORT_SYMBOL(ndlc_probe);
 void ndlc_remove(struct llt_ndlc *ndlc)
 {
 	/* cancel timers */
-	del_timer_sync(&ndlc->t1_timer);
-	del_timer_sync(&ndlc->t2_timer);
+	timer_delete_sync(&ndlc->t1_timer);
+	timer_delete_sync(&ndlc->t2_timer);
 	ndlc->t2_active = false;
 	ndlc->t1_active = false;
 	/* cancel work */
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index b2f1ced..8cfe540 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -257,7 +257,7 @@ static void st_nci_hci_admin_event_received(struct nci_dev *ndev,
 	case ST_NCI_EVT_HOT_PLUG:
 		if (info->se_info.se_active) {
 			if (!ST_NCI_EVT_HOT_PLUG_IS_INHIBITED(skb)) {
-				del_timer_sync(&info->se_info.se_active_timer);
+				timer_delete_sync(&info->se_info.se_active_timer);
 				info->se_info.se_active = false;
 				complete(&info->se_info.req_completion);
 			} else {
@@ -282,7 +282,7 @@ static int st_nci_hci_apdu_reader_event_received(struct nci_dev *ndev,
 
 	switch (event) {
 	case ST_NCI_EVT_TRANSMIT_DATA:
-		del_timer_sync(&info->se_info.bwi_timer);
+		timer_delete_sync(&info->se_info.bwi_timer);
 		info->se_info.bwi_active = false;
 		info->se_info.cb(info->se_info.cb_context,
 				 skb->data, skb->len, 0);
@@ -415,7 +415,7 @@ void st_nci_hci_cmd_received(struct nci_dev *ndev, u8 pipe, u8 cmd,
 
 		if (ndev->hci_dev->count_pipes ==
 		    ndev->hci_dev->expected_pipes) {
-			del_timer_sync(&info->se_info.se_active_timer);
+			timer_delete_sync(&info->se_info.se_active_timer);
 			info->se_info.se_active = false;
 			ndev->hci_dev->count_pipes = 0;
 			complete(&info->se_info.req_completion);
@@ -751,9 +751,9 @@ void st_nci_se_deinit(struct nci_dev *ndev)
 	struct st_nci_info *info = nci_get_drvdata(ndev);
 
 	if (info->se_info.bwi_active)
-		del_timer_sync(&info->se_info.bwi_timer);
+		timer_delete_sync(&info->se_info.bwi_timer);
 	if (info->se_info.se_active)
-		del_timer_sync(&info->se_info.se_active_timer);
+		timer_delete_sync(&info->se_info.se_active_timer);
 
 	info->se_info.se_active = false;
 	info->se_info.bwi_active = false;
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 161caf2..bec6f60 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -844,7 +844,7 @@ static void st21nfca_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
 			info->se_info.count_pipes++;
 
 		if (info->se_info.count_pipes == info->se_info.expected_pipes) {
-			del_timer_sync(&info->se_info.se_active_timer);
+			timer_delete_sync(&info->se_info.se_active_timer);
 			info->se_info.se_active = false;
 			info->se_info.count_pipes = 0;
 			complete(&info->se_info.req_completion);
@@ -864,7 +864,7 @@ static int st21nfca_admin_event_received(struct nfc_hci_dev *hdev, u8 event,
 	case ST21NFCA_EVT_HOT_PLUG:
 		if (info->se_info.se_active) {
 			if (!ST21NFCA_EVT_HOT_PLUG_IS_INHIBITED(skb)) {
-				del_timer_sync(&info->se_info.se_active_timer);
+				timer_delete_sync(&info->se_info.se_active_timer);
 				info->se_info.se_active = false;
 				complete(&info->se_info.req_completion);
 			} else {
diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index dae288b..9a50f3c 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -380,7 +380,7 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 
 	switch (event) {
 	case ST21NFCA_EVT_TRANSMIT_DATA:
-		del_timer_sync(&info->se_info.bwi_timer);
+		timer_delete_sync(&info->se_info.bwi_timer);
 		cancel_work_sync(&info->se_info.timeout_work);
 		info->se_info.bwi_active = false;
 		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
@@ -435,9 +435,9 @@ void st21nfca_se_deinit(struct nfc_hci_dev *hdev)
 	struct st21nfca_hci_info *info = nfc_hci_get_clientdata(hdev);
 
 	if (info->se_info.bwi_active)
-		del_timer_sync(&info->se_info.bwi_timer);
+		timer_delete_sync(&info->se_info.bwi_timer);
 	if (info->se_info.se_active)
-		del_timer_sync(&info->se_info.se_active_timer);
+		timer_delete_sync(&info->se_info.se_active_timer);
 
 	cancel_work_sync(&info->se_info.timeout_work);
 	info->se_info.bwi_active = false;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca8..89be591 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -860,7 +860,7 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 	if (nr_change_groups)
 		mod_timer(&ctrl->anatt_timer, ctrl->anatt * HZ * 2 + jiffies);
 	else
-		del_timer_sync(&ctrl->anatt_timer);
+		timer_delete_sync(&ctrl->anatt_timer);
 out_unlock:
 	mutex_unlock(&ctrl->ana_lock);
 	return error;
@@ -900,7 +900,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_ctrl_use_ana(ctrl))
 		return;
-	del_timer_sync(&ctrl->anatt_timer);
+	timer_delete_sync(&ctrl->anatt_timer);
 	cancel_work_sync(&ctrl->ana_work);
 }
 
diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 4547ac4..474515d 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -73,7 +73,7 @@ int parport_wait_event (struct parport *port, signed long timeout)
 	timer_setup(&port->timer, timeout_waiting_on_port, 0);
 	mod_timer(&port->timer, jiffies + timeout);
 	ret = down_interruptible (&port->physport->ieee1284.irq);
-	if (!del_timer_sync(&port->timer) && !ret)
+	if (!timer_delete_sync(&port->timer) && !ret)
 		/* Timed out. */
 		ret = 1;
 
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index c01968e..20529d1 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1794,7 +1794,7 @@ static void interrupt_event_handler(struct controller *ctrl)
 				} else if (ctrl->event_queue[loop].event_type ==
 					   INT_BUTTON_CANCEL) {
 					dbg("button cancel\n");
-					del_timer(&p_slot->task_event);
+					timer_delete(&p_slot->task_event);
 
 					mutex_lock(&ctrl->crit_sect);
 
diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index bfbec7c..387b855 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -564,7 +564,7 @@ void shpchp_release_ctlr(struct controller *ctrl)
 	shpc_writel(ctrl, SERR_INTR_ENABLE, serr_int);
 
 	if (shpchp_poll_mode)
-		del_timer(&ctrl->poll_timer);
+		timer_delete(&ctrl->poll_timer);
 	else {
 		free_irq(ctrl->pci_dev->irq, ctrl);
 		pci_disable_msi(ctrl->pci_dev);
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index 86a3578..1e464b9 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1324,7 +1324,7 @@ static void __exit exit_i82365(void)
     }
     platform_device_unregister(i82365_device);
     if (poll_interval != 0)
-	del_timer_sync(&poll_timer);
+	timer_delete_sync(&poll_timer);
     if (grab_irq != 0)
 	free_irq(cs_irq, pcic_interrupt);
     for (i = 0; i < sockets; i++) {
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 1deb996..d361124 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -766,7 +766,7 @@ EXPORT_SYMBOL(soc_pcmcia_init_one);
 
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 {
-	del_timer_sync(&skt->poll_timer);
+	timer_delete_sync(&skt->poll_timer);
 
 	pcmcia_unregister_socket(&skt->socket);
 
@@ -865,7 +865,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	return ret;
 
  out_err_8:
-	del_timer_sync(&skt->poll_timer);
+	timer_delete_sync(&skt->poll_timer);
 	pcmcia_unregister_socket(&skt->socket);
 
  out_err_7:
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 5ef8886..060aed0 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -509,7 +509,7 @@ static void __exit exit_tcic(void)
 {
     int i;
 
-    del_timer_sync(&poll_timer);
+    timer_delete_sync(&poll_timer);
     if (cs_irq != 0) {
 	tcic_aux_setw(TCIC_AUX_SYSCFG, TCIC_SYSCFG_AUTOBUSY|0x0a00);
 	free_irq(cs_irq, tcic_interrupt);
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 300cdaa..aae99ad 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1320,7 +1320,7 @@ static void mlxbf_tmfifo_cleanup(struct mlxbf_tmfifo *fifo)
 	int i;
 
 	fifo->is_ready = false;
-	del_timer_sync(&fifo->timer);
+	timer_delete_sync(&fifo->timer);
 	mlxbf_tmfifo_disable_irqs(fifo);
 	cancel_work_sync(&fifo->work);
 	for (i = 0; i < MLXBF_TMFIFO_VDEV_MAX; i++)
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 79a7b68..5d717b1 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1108,7 +1108,7 @@ static int ips_monitor(void *data)
 			last_sample_period = 1;
 	} while (!kthread_should_stop());
 
-	del_timer_sync(&ips->timer);
+	timer_delete_sync(&ips->timer);
 
 	dev_dbg(ips->dev, "ips-monitor thread stopped\n");
 
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3197aaa..b52390f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -538,7 +538,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	del_timer_sync(&sony_laptop_input.release_key_timer);
+	timer_delete_sync(&sony_laptop_input.release_key_timer);
 
 	/*
 	 * Generate key-up events for remaining keys. Note that we don't
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 75c1bae..374ceef 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -229,7 +229,7 @@ static void pps_gpio_remove(struct platform_device *pdev)
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
 	pps_unregister_source(data->pps);
-	del_timer_sync(&data->echo_timer);
+	timer_delete_sync(&data->echo_timer);
 	/* reset echo pin in any case */
 	gpiod_set_value(data->echo_pin, 0);
 	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
diff --git a/drivers/pps/clients/pps-ktimer.c b/drivers/pps/clients/pps-ktimer.c
index 2f46554..121bd29 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -58,7 +58,7 @@ static void __exit pps_ktimer_exit(void)
 {
 	dev_dbg(&pps->dev, "ktimer PPS source unregistered\n");
 
-	del_timer_sync(&ktimer);
+	timer_delete_sync(&ktimer);
 	pps_unregister_source(pps);
 }
 
diff --git a/drivers/pps/generators/pps_gen-dummy.c b/drivers/pps/generators/pps_gen-dummy.c
index 55de4ae..547fa7f 100644
--- a/drivers/pps/generators/pps_gen-dummy.c
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -52,7 +52,7 @@ static int pps_gen_dummy_enable(struct pps_gen_device *pps_gen, bool enable)
 	if (enable)
 		mod_timer(&ktimer, jiffies + get_random_delay());
 	else
-		del_timer_sync(&ktimer);
+		timer_delete_sync(&ktimer);
 
 	return 0;
 }
@@ -73,7 +73,7 @@ static const struct pps_gen_source_info pps_gen_dummy_info = {
 
 static void __exit pps_gen_dummy_exit(void)
 {
-	del_timer_sync(&ktimer);
+	timer_delete_sync(&ktimer);
 	pps_gen_unregister_source(pps_gen);
 }
 
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b25635c..7945c6b 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4499,7 +4499,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	if (timer_pending(&bp->watchdog))
-		del_timer_sync(&bp->watchdog);
+		timer_delete_sync(&bp->watchdog);
 	if (bp->ts0)
 		ptp_ocp_unregister_ext(bp->ts0);
 	if (bp->ts1)
diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index c4a3ab5..0eeae5b 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -90,7 +90,7 @@ static int clear_uie(struct rtc_device *rtc)
 		rtc->stop_uie_polling = 1;
 		if (rtc->uie_timer_active) {
 			spin_unlock_irq(&rtc->irq_lock);
-			del_timer_sync(&rtc->uie_timer);
+			timer_delete_sync(&rtc->uie_timer);
 			spin_lock_irq(&rtc->irq_lock);
 			rtc->uie_timer_active = 0;
 		}
diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index a68b8c8..a9f5b94 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -44,7 +44,7 @@ static int test_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	timeout = rtc_tm_to_time64(&alrm->time) - ktime_get_real_seconds();
 	timeout -= rtd->offset;
 
-	del_timer(&rtd->alarm);
+	timer_delete(&rtd->alarm);
 
 	expires = jiffies + timeout * HZ;
 	if (expires > U32_MAX)
@@ -86,7 +86,7 @@ static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	if (enable)
 		add_timer(&rtd->alarm);
 	else
-		del_timer(&rtd->alarm);
+		timer_delete(&rtd->alarm);
 
 	return 0;
 }
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 31bfb49..cf36d3b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1507,7 +1507,7 @@ static void dasd_device_timeout(struct timer_list *t)
 void dasd_device_set_timer(struct dasd_device *device, int expires)
 {
 	if (expires == 0)
-		del_timer(&device->timer);
+		timer_delete(&device->timer);
 	else
 		mod_timer(&device->timer, jiffies + expires);
 }
@@ -1518,7 +1518,7 @@ EXPORT_SYMBOL(dasd_device_set_timer);
  */
 void dasd_device_clear_timer(struct dasd_device *device)
 {
-	del_timer(&device->timer);
+	timer_delete(&device->timer);
 }
 EXPORT_SYMBOL(dasd_device_clear_timer);
 
@@ -2692,7 +2692,7 @@ static void dasd_block_timeout(struct timer_list *t)
 void dasd_block_set_timer(struct dasd_block *block, int expires)
 {
 	if (expires == 0)
-		del_timer(&block->timer);
+		timer_delete(&block->timer);
 	else
 		mod_timer(&block->timer, jiffies + expires);
 }
@@ -2703,7 +2703,7 @@ EXPORT_SYMBOL(dasd_block_set_timer);
  */
 void dasd_block_clear_timer(struct dasd_block *block)
 {
-	del_timer(&block->timer);
+	timer_delete(&block->timer);
 }
 EXPORT_SYMBOL(dasd_block_clear_timer);
 
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 1a31908..34f3820 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -793,7 +793,7 @@ static void tty3270_deactivate(struct raw3270_view *view)
 {
 	struct tty3270 *tp = container_of(view, struct tty3270, view);
 
-	del_timer(&tp->timer);
+	timer_delete(&tp->timer);
 }
 
 static void tty3270_irq(struct tty3270 *tp, struct raw3270_request *rq, struct irb *irb)
@@ -1060,7 +1060,7 @@ static void tty3270_free(struct raw3270_view *view)
 {
 	struct tty3270 *tp = container_of(view, struct tty3270, view);
 
-	del_timer_sync(&tp->timer);
+	timer_delete_sync(&tp->timer);
 	tty3270_free_screen(tp->screen, tp->allocated_lines);
 	free_page((unsigned long)tp->converted_line);
 	kfree(tp->input);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 45bd001..840be75 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -261,7 +261,7 @@ __sclp_queue_read_req(void)
 static inline void
 __sclp_set_request_timer(unsigned long time, void (*cb)(struct timer_list *))
 {
-	del_timer(&sclp_request_timer);
+	timer_delete(&sclp_request_timer);
 	sclp_request_timer.function = cb;
 	sclp_request_timer.expires = jiffies + time;
 	add_timer(&sclp_request_timer);
@@ -407,7 +407,7 @@ __sclp_start_request(struct sclp_req *req)
 
 	if (sclp_running_state != sclp_running_state_idle)
 		return 0;
-	del_timer(&sclp_request_timer);
+	timer_delete(&sclp_request_timer);
 	rc = sclp_service_call_trace(req->command, req->sccb);
 	req->start_count++;
 
@@ -442,7 +442,7 @@ sclp_process_queue(void)
 		spin_unlock_irqrestore(&sclp_lock, flags);
 		return;
 	}
-	del_timer(&sclp_request_timer);
+	timer_delete(&sclp_request_timer);
 	while (!list_empty(&sclp_req_queue)) {
 		req = list_entry(sclp_req_queue.next, struct sclp_req, list);
 		rc = __sclp_start_request(req);
@@ -662,7 +662,7 @@ static void sclp_interrupt_handler(struct ext_code ext_code,
 			!ok_response(finished_sccb, active_cmd));
 
 	if (finished_sccb) {
-		del_timer(&sclp_request_timer);
+		timer_delete(&sclp_request_timer);
 		sclp_running_state = sclp_running_state_reset_pending;
 		req = __sclp_find_req(finished_sccb);
 		if (req) {
@@ -739,7 +739,7 @@ sclp_sync_wait(void)
 	/* Loop until driver state indicates finished request */
 	while (sclp_running_state != sclp_running_state_idle) {
 		/* Check for expired request timer */
-		if (get_tod_clock_fast() > timeout && del_timer(&sclp_request_timer))
+		if (get_tod_clock_fast() > timeout && timer_delete(&sclp_request_timer))
 			sclp_request_timer.function(&sclp_request_timer);
 		cpu_relax();
 	}
@@ -1165,7 +1165,7 @@ sclp_check_interface(void)
 		 * with IRQs enabled. */
 		irq_subclass_unregister(IRQ_SUBCLASS_SERVICE_SIGNAL);
 		spin_lock_irqsave(&sclp_lock, flags);
-		del_timer(&sclp_request_timer);
+		timer_delete(&sclp_request_timer);
 		rc = -EBUSY;
 		if (sclp_init_req.status == SCLP_REQ_DONE) {
 			if (sccb->header.response_code == 0x20) {
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index 6a030ba..d8544c4 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -109,7 +109,7 @@ static void sclp_console_sync_queue(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sclp_con_lock, flags);
-	del_timer(&sclp_con_timer);
+	timer_delete(&sclp_con_timer);
 	while (sclp_con_queue_running) {
 		spin_unlock_irqrestore(&sclp_con_lock, flags);
 		sclp_sync_wait();
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 33b9c96..62979ad 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -231,7 +231,7 @@ sclp_vt220_emit_current(void)
 			list_add_tail(&sclp_vt220_current_request->list,
 				      &sclp_vt220_outqueue);
 			sclp_vt220_current_request = NULL;
-			del_timer(&sclp_vt220_timer);
+			timer_delete(&sclp_vt220_timer);
 		}
 		sclp_vt220_flush_later = 0;
 	}
@@ -798,7 +798,7 @@ sclp_vt220_notify(struct notifier_block *self,
 	sclp_vt220_emit_current();
 
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	del_timer(&sclp_vt220_timer);
+	timer_delete(&sclp_vt220_timer);
 	while (sclp_vt220_queue_running) {
 		spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 		sclp_sync_wait();
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index ce8a440..48e8417 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -1108,7 +1108,7 @@ __tape_do_irq (struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 				 struct tape_request, list);
 		if (req->status == TAPE_REQUEST_LONG_BUSY) {
 			DBF_EVENT(3, "(%08x): del timer\n", device->cdev_id);
-			if (del_timer(&device->lb_timeout)) {
+			if (timer_delete(&device->lb_timeout)) {
 				tape_put_device(device);
 				__tape_start_next_request(device);
 			}
diff --git a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
index f7e75d9..b760386 100644
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -73,7 +73,7 @@ tape_std_assign(struct tape_device *device)
 
 	rc = tape_do_io_interruptible(device, request);
 
-	del_timer_sync(&request->timer);
+	timer_delete_sync(&request->timer);
 
 	if (rc != 0) {
 		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 42791fa..e1b1fbd 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -115,7 +115,7 @@ void
 ccw_device_set_timeout(struct ccw_device *cdev, int expires)
 {
 	if (expires == 0)
-		del_timer(&cdev->private->timer);
+		timer_delete(&cdev->private->timer);
 	else
 		mod_timer(&cdev->private->timer, jiffies + expires);
 }
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index 165de15..ac38235 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -114,7 +114,7 @@ static void eadm_subchannel_set_timeout(struct subchannel *sch, int expires)
 	struct eadm_private *private = get_eadm_private(sch);
 
 	if (expires == 0)
-		del_timer(&private->timer);
+		timer_delete(&private->timer);
 	else
 		mod_timer(&private->timer, jiffies + expires);
 }
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 9a0e6e4..4088fda 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -1289,7 +1289,7 @@ void ap_queue_prepare_remove(struct ap_queue *aq)
 	/* move queue device state to SHUTDOWN in progress */
 	aq->dev_state = AP_DEV_STATE_SHUTDOWN;
 	spin_unlock_bh(&aq->lock);
-	del_timer_sync(&aq->timeout);
+	timer_delete_sync(&aq->timeout);
 }
 
 void ap_queue_remove(struct ap_queue *aq)
diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index 8672d22..5fcdce1 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -158,7 +158,7 @@ fsm_deltimer(fsm_timer *this)
 	printk(KERN_DEBUG "fsm(%s): Delete timer %p\n", this->fi->name,
 		this);
 #endif
-	del_timer(&this->tl);
+	timer_delete(&this->tl);
 }
 
 int
@@ -188,7 +188,7 @@ fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
 		this->fi->name, this, millisec);
 #endif
 
-	del_timer(&this->tl);
+	timer_delete(&this->tl);
 	timer_setup(&this->tl, fsm_expire_timer, 0);
 	this->expire_event = event;
 	this->event_arg = arg;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 20328d6..f5cfaeb 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -7088,7 +7088,7 @@ int qeth_stop(struct net_device *dev)
 	netif_tx_disable(dev);
 
 	qeth_for_each_output_queue(card, queue, i) {
-		del_timer_sync(&queue->timer);
+		timer_delete_sync(&queue->timer);
 		/* Queues may get re-allocated, so remove the NAPIs. */
 		netif_napi_del(&queue->napi);
 	}
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 99d6b3f..d5f5f56 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -458,7 +458,7 @@ static void zfcp_fsf_req_complete(struct zfcp_fsf_req *req)
 		return;
 	}
 
-	del_timer_sync(&req->timer);
+	timer_delete_sync(&req->timer);
 	zfcp_fsf_protstatus_eval(req);
 	zfcp_fsf_fsfstatus_eval(req);
 	req->handler(req);
@@ -891,7 +891,7 @@ static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 	req->qdio_req.qdio_outb_usage = atomic_read(&qdio->req_q_free);
 	req->issued = get_tod_clock();
 	if (zfcp_qdio_send(qdio, &req->qdio_req)) {
-		del_timer_sync(&req->timer);
+		timer_delete_sync(&req->timer);
 
 		/* lookup request again, list might have changed */
 		if (zfcp_reqlist_find_rm(adapter->req_list, req_id) == NULL)
diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 8cbc5e1..0957e3f 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -408,7 +408,7 @@ void zfcp_qdio_close(struct zfcp_qdio *qdio)
 
 	tasklet_disable(&qdio->irq_tasklet);
 	tasklet_disable(&qdio->request_tasklet);
-	del_timer_sync(&qdio->request_timer);
+	timer_delete_sync(&qdio->request_timer);
 	qdio_stop_irq(adapter->ccw_device);
 	qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR);
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 3e3100d..f9372a8 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -6181,7 +6181,7 @@ ahd_shutdown(void *arg)
 	/*
 	 * Stop periodic timer callbacks.
 	 */
-	del_timer_sync(&ahd->stat_timer);
+	timer_delete_sync(&ahd->stat_timer);
 
 	/* This will reset most registers to 0, but not all */
 	ahd_reset(ahd, /*reinit*/FALSE);
@@ -6975,7 +6975,7 @@ static const char *termstat_strings[] = {
 static void
 ahd_timer_reset(struct timer_list *timer, int usec)
 {
-	del_timer(timer);
+	timer_delete(timer);
 	timer->expires = jiffies + (usec * HZ)/1000000;
 	add_timer(timer);
 }
diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index 9dda296..e743933 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -731,7 +731,7 @@ static void asd_dl_tasklet_handler(unsigned long data)
 			goto next_1;
 		} else if (ascb->scb->header.opcode == EMPTY_SCB) {
 			goto out;
-		} else if (!ascb->uldd_timer && !del_timer(&ascb->timer)) {
+		} else if (!ascb->uldd_timer && !timer_delete(&ascb->timer)) {
 			goto next_1;
 		}
 		spin_lock_irqsave(&seq->pend_q_lock, flags);
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 538a586..adf3d91 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -851,7 +851,7 @@ static void asd_free_queues(struct asd_ha_struct *asd_ha)
 		 * times out.  Apparently we don't wait for the CONTROL PHY
 		 * to complete, so it doesn't matter if we kill the timer.
 		 */
-		del_timer_sync(&ascb->timer);
+		timer_delete_sync(&ascb->timer);
 		WARN_ON(ascb->scb->header.opcode != CONTROL_PHY);
 
 		list_del_init(pos);
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 27d32b8..d45dbf9 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -31,7 +31,7 @@ static int asd_enqueue_internal(struct asd_ascb *ascb,
 
 	res = asd_post_ascb_list(ascb->ha, ascb, 1);
 	if (unlikely(res))
-		del_timer(&ascb->timer);
+		timer_delete(&ascb->timer);
 	return res;
 }
 
@@ -58,7 +58,7 @@ static void asd_clear_nexus_tasklet_complete(struct asd_ascb *ascb,
 {
 	struct tasklet_completion_status *tcs = ascb->uldd_task;
 	ASD_DPRINTK("%s: here\n", __func__);
-	if (!del_timer(&ascb->timer)) {
+	if (!timer_delete(&ascb->timer)) {
 		ASD_DPRINTK("%s: couldn't delete timer\n", __func__);
 		return;
 	}
@@ -303,7 +303,7 @@ static void asd_tmf_tasklet_complete(struct asd_ascb *ascb,
 {
 	struct tasklet_completion_status *tcs;
 
-	if (!del_timer(&ascb->timer))
+	if (!timer_delete(&ascb->timer))
 		return;
 
 	tcs = ascb->uldd_task;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 221a520..b450b1f 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1161,8 +1161,8 @@ static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 out_free_sysfs:
 	if (set_date_time)
-		del_timer_sync(&acb->refresh_timer);
-	del_timer_sync(&acb->eternal_timer);
+		timer_delete_sync(&acb->refresh_timer);
+	timer_delete_sync(&acb->eternal_timer);
 	flush_work(&acb->arcmsr_do_message_isr_bh);
 	arcmsr_stop_adapter_bgrb(acb);
 	arcmsr_flush_adapter_cache(acb);
@@ -1204,9 +1204,9 @@ static int __maybe_unused arcmsr_suspend(struct device *dev)
 
 	arcmsr_disable_outbound_ints(acb);
 	arcmsr_free_irq(pdev, acb);
-	del_timer_sync(&acb->eternal_timer);
+	timer_delete_sync(&acb->eternal_timer);
 	if (set_date_time)
-		del_timer_sync(&acb->refresh_timer);
+		timer_delete_sync(&acb->refresh_timer);
 	flush_work(&acb->arcmsr_do_message_isr_bh);
 	arcmsr_stop_adapter_bgrb(acb);
 	arcmsr_flush_adapter_cache(acb);
@@ -1685,9 +1685,9 @@ static void arcmsr_free_pcidev(struct AdapterControlBlock *acb)
 	arcmsr_free_sysfs_attr(acb);
 	scsi_remove_host(host);
 	flush_work(&acb->arcmsr_do_message_isr_bh);
-	del_timer_sync(&acb->eternal_timer);
+	timer_delete_sync(&acb->eternal_timer);
 	if (set_date_time)
-		del_timer_sync(&acb->refresh_timer);
+		timer_delete_sync(&acb->refresh_timer);
 	pdev = acb->pdev;
 	arcmsr_free_irq(pdev, acb);
 	arcmsr_free_ccb_pool(acb);
@@ -1718,9 +1718,9 @@ static void arcmsr_remove(struct pci_dev *pdev)
 	arcmsr_free_sysfs_attr(acb);
 	scsi_remove_host(host);
 	flush_work(&acb->arcmsr_do_message_isr_bh);
-	del_timer_sync(&acb->eternal_timer);
+	timer_delete_sync(&acb->eternal_timer);
 	if (set_date_time)
-		del_timer_sync(&acb->refresh_timer);
+		timer_delete_sync(&acb->refresh_timer);
 	arcmsr_disable_outbound_ints(acb);
 	arcmsr_stop_adapter_bgrb(acb);
 	arcmsr_flush_adapter_cache(acb);	
@@ -1765,9 +1765,9 @@ static void arcmsr_shutdown(struct pci_dev *pdev)
 		(struct AdapterControlBlock *)host->hostdata;
 	if (acb->acb_flags & ACB_F_ADAPTER_REMOVED)
 		return;
-	del_timer_sync(&acb->eternal_timer);
+	timer_delete_sync(&acb->eternal_timer);
 	if (set_date_time)
-		del_timer_sync(&acb->refresh_timer);
+		timer_delete_sync(&acb->refresh_timer);
 	arcmsr_disable_outbound_ints(acb);
 	arcmsr_free_irq(pdev, acb);
 	flush_work(&acb->arcmsr_do_message_isr_bh);
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 4ce0b2d..e0b55d8 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2331,7 +2331,7 @@ static void fas216_eh_timer(struct timer_list *t)
 
 	fas216_log(info, LOG_ERROR, "error handling timed out\n");
 
-	del_timer(&info->eh_timer);
+	timer_delete(&info->eh_timer);
 
 	if (info->rst_bus_status == 0)
 		info->rst_bus_status = -1;
@@ -2532,7 +2532,7 @@ int fas216_eh_device_reset(struct scsi_cmnd *SCpnt)
 		 */
 		wait_event(info->eh_wait, info->rst_dev_status);
 
-		del_timer_sync(&info->eh_timer);
+		timer_delete_sync(&info->eh_timer);
 		spin_lock_irqsave(&info->host_lock, flags);
 		info->rstSCpnt = NULL;
 
@@ -2622,7 +2622,7 @@ int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
 	 * Wait one second for the interrupt.
 	 */
 	wait_event(info->eh_wait, info->rst_bus_status);
-	del_timer_sync(&info->eh_timer);
+	timer_delete_sync(&info->eh_timer);
 
 	fas216_log(info, LOG_ERROR, "bus reset complete: %s\n",
 		   info->rst_bus_status == 1 ? "success" : "failed");
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index a8b399e..7d1b767 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -5448,7 +5448,7 @@ static pci_ers_result_t beiscsi_eeh_err_detected(struct pci_dev *pdev,
 		    "BM_%d : EEH error detected\n");
 
 	/* first stop UE detection when PCI error detected */
-	del_timer_sync(&phba->hw_check);
+	timer_delete_sync(&phba->hw_check);
 	cancel_delayed_work_sync(&phba->recover_port);
 
 	/* sessions are no longer valid, so first fail the sessions */
@@ -5746,7 +5746,7 @@ static void beiscsi_remove(struct pci_dev *pcidev)
 	}
 
 	/* first stop UE detection before unloading */
-	del_timer_sync(&phba->hw_check);
+	timer_delete_sync(&phba->hw_check);
 	cancel_delayed_work_sync(&phba->recover_port);
 	cancel_work_sync(&phba->sess_work);
 
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index f015c53..598f2fc 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -327,7 +327,7 @@ bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event event)
 	case BFAD_E_EXIT_COMP:
 		bfa_sm_set_state(bfad, bfad_sm_uninit);
 		bfad_remove_intr(bfad);
-		del_timer_sync(&bfad->hal_tmo);
+		timer_delete_sync(&bfad->hal_tmo);
 		break;
 
 	default:
@@ -376,7 +376,7 @@ bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event event)
 	case BFAD_E_EXIT_COMP:
 		bfa_sm_set_state(bfad, bfad_sm_uninit);
 		bfad_remove_intr(bfad);
-		del_timer_sync(&bfad->hal_tmo);
+		timer_delete_sync(&bfad->hal_tmo);
 		bfad_im_probe_undo(bfad);
 		bfad->bfad_flags &= ~BFAD_FC4_PROBE_DONE;
 		bfad_uncfg_pport(bfad);
@@ -1421,7 +1421,7 @@ bfad_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 		/* Suspend/fail all bfa operations */
 		bfa_ioc_suspend(&bfad->bfa.ioc);
 		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
-		del_timer_sync(&bfad->hal_tmo);
+		timer_delete_sync(&bfad->hal_tmo);
 		ret = PCI_ERS_RESULT_CAN_RECOVER;
 		break;
 	case pci_channel_io_frozen: /* fatal error */
@@ -1435,7 +1435,7 @@ bfad_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 		wait_for_completion(&bfad->comp);
 
 		bfad_remove_intr(bfad);
-		del_timer_sync(&bfad->hal_tmo);
+		timer_delete_sync(&bfad->hal_tmo);
 		pci_disable_device(pdev);
 		ret = PCI_ERS_RESULT_NEED_RESET;
 		break;
@@ -1566,7 +1566,7 @@ bfad_pci_mmio_enabled(struct pci_dev *pdev)
 	wait_for_completion(&bfad->comp);
 
 	bfad_remove_intr(bfad);
-	del_timer_sync(&bfad->hal_tmo);
+	timer_delete_sync(&bfad->hal_tmo);
 	pci_disable_device(pdev);
 
 	return PCI_ERS_RESULT_NEED_RESET;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 5ac20c9..de6574c 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1599,7 +1599,7 @@ static void bnx2fc_interface_cleanup(struct bnx2fc_interface *interface)
 	struct bnx2fc_hba *hba = interface->hba;
 
 	/* Stop the transmit retry timer */
-	del_timer_sync(&port->timer);
+	timer_delete_sync(&port->timer);
 
 	/* Free existing transmit skbs */
 	fcoe_clean_pending_queue(lport);
@@ -1938,7 +1938,7 @@ static void bnx2fc_fw_destroy(struct bnx2fc_hba *hba)
 			if (signal_pending(current))
 				flush_signals(current);
 
-			del_timer_sync(&hba->destroy_timer);
+			timer_delete_sync(&hba->destroy_timer);
 		}
 		bnx2fc_unbind_adapter_devices(hba);
 	}
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index eb32091..b8227cf 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -74,7 +74,7 @@ static void bnx2fc_ofld_wait(struct bnx2fc_rport *tgt)
 				  &tgt->flags)));
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&tgt->ofld_timer);
+	timer_delete_sync(&tgt->ofld_timer);
 }
 
 static void bnx2fc_offload_session(struct fcoe_port *port,
@@ -283,7 +283,7 @@ static void bnx2fc_upld_wait(struct bnx2fc_rport *tgt)
 				  &tgt->flags)));
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&tgt->upld_timer);
+	timer_delete_sync(&tgt->upld_timer);
 }
 
 static void bnx2fc_upload_session(struct fcoe_port *port,
diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index 9971f32..6c80e5b 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -1626,7 +1626,7 @@ static int bnx2i_conn_start(struct iscsi_cls_conn *cls_conn)
 
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&bnx2i_conn->ep->ofld_timer);
+	timer_delete_sync(&bnx2i_conn->ep->ofld_timer);
 
 	iscsi_conn_start(cls_conn);
 	return 0;
@@ -1749,7 +1749,7 @@ static int bnx2i_tear_down_conn(struct bnx2i_hba *hba,
 
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&ep->ofld_timer);
+	timer_delete_sync(&ep->ofld_timer);
 
 	bnx2i_ep_destroy_list_del(hba, ep);
 
@@ -1861,7 +1861,7 @@ static struct iscsi_endpoint *bnx2i_ep_connect(struct Scsi_Host *shost,
 
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&bnx2i_ep->ofld_timer);
+	timer_delete_sync(&bnx2i_ep->ofld_timer);
 
 	bnx2i_ep_ofld_list_del(hba, bnx2i_ep);
 
@@ -2100,7 +2100,7 @@ int bnx2i_hw_ep_disconnect(struct bnx2i_endpoint *bnx2i_ep)
 
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&bnx2i_ep->ofld_timer);
+	timer_delete_sync(&bnx2i_ep->ofld_timer);
 
 destroy_conn:
 	bnx2i_ep_active_list_del(hba, bnx2i_ep);
diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_hw.c
index e43c541..beded09 100644
--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -3701,7 +3701,7 @@ csio_mberr_worker(void *data)
 	struct csio_mb *mbp_next;
 	int rv;
 
-	del_timer_sync(&mbm->timer);
+	timer_delete_sync(&mbm->timer);
 
 	spin_lock_irq(&hw->lock);
 	if (list_empty(&mbm->cbfn_q)) {
@@ -4210,7 +4210,7 @@ csio_mgmtm_init(struct csio_mgmtm *mgmtm, struct csio_hw *hw)
 static void
 csio_mgmtm_exit(struct csio_mgmtm *mgmtm)
 {
-	del_timer_sync(&mgmtm->mgmt_timer);
+	timer_delete_sync(&mgmtm->mgmt_timer);
 }
 
 
diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 94810b1..c7b4c46 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1619,7 +1619,7 @@ csio_mb_cancel_all(struct csio_hw *hw, struct list_head *cbfn_q)
 		mbp = mbm->mcurrent;
 
 		/* Stop mailbox completion timer */
-		del_timer_sync(&mbm->timer);
+		timer_delete_sync(&mbm->timer);
 
 		/* Add completion to tail of cbfn queue */
 		list_add_tail(&mbp->list, cbfn_q);
@@ -1682,7 +1682,7 @@ csio_mbm_init(struct csio_mbm *mbm, struct csio_hw *hw,
 void
 csio_mbm_exit(struct csio_mbm *mbm)
 {
-	del_timer_sync(&mbm->timer);
+	timer_delete_sync(&mbm->timer);
 
 	CSIO_DB_ASSERT(mbm->mcurrent == NULL);
 	CSIO_DB_ASSERT(list_empty(&mbm->req_q));
diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index ec65302..461d38e 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -495,7 +495,7 @@ static int do_act_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
 
 	spin_lock_bh(&csk->lock);
 	if (csk->retry_timer.function) {
-		del_timer(&csk->retry_timer);
+		timer_delete(&csk->retry_timer);
 		csk->retry_timer.function = NULL;
 	}
 
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index c07d2e3..aaba294 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -930,7 +930,7 @@ static void do_act_establish(struct cxgbi_device *cdev, struct sk_buff *skb)
 			csk, csk->state, csk->flags, csk->tid);
 
 	if (csk->retry_timer.function) {
-		del_timer(&csk->retry_timer);
+		timer_delete(&csk->retry_timer);
 		csk->retry_timer.function = NULL;
 	}
 
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index e71de24..8dc6be9 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -765,7 +765,7 @@ static void waiting_process_next(struct AdapterCtlBlk *acb)
 		return;
 
 	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
+		timer_delete(&acb->waiting_timer);
 
 	if (list_empty(dcb_list_head))
 		return;
@@ -1153,7 +1153,7 @@ static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
 		cmd, cmd->device->id, (u8)cmd->device->lun, cmd);
 
 	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
+		timer_delete(&acb->waiting_timer);
 
 	/*
 	 * disable interrupt    
@@ -1561,7 +1561,7 @@ static void dc395x_handle_interrupt(struct AdapterCtlBlk *acb,
 	/*dprintkl(KERN_DEBUG, "handle_interrupt: intstatus = 0x%02x ", scsi_intstatus); */
 
 	if (timer_pending(&acb->selto_timer))
-		del_timer(&acb->selto_timer);
+		timer_delete(&acb->selto_timer);
 
 	if (scsi_intstatus & (INT_SELTIMEOUT | INT_DISCONNECT)) {
 		disconnect(acb);	/* bus free interrupt  */
@@ -3454,7 +3454,7 @@ static void scsi_reset_detect(struct AdapterCtlBlk *acb)
 	dprintkl(KERN_INFO, "scsi_reset_detect: acb=%p\n", acb);
 	/* delay half a second */
 	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
+		timer_delete(&acb->waiting_timer);
 
 	DC395x_write8(acb, TRM_S1040_SCSI_CONTROL, DO_RSTMODULE);
 	DC395x_write8(acb, TRM_S1040_DMA_CONTROL, DMARESETMODULE);
@@ -4415,9 +4415,9 @@ static void adapter_uninit(struct AdapterCtlBlk *acb)
 
 	/* remove timers */
 	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
+		timer_delete(&acb->waiting_timer);
 	if (timer_pending(&acb->selto_timer))
-		del_timer(&acb->selto_timer);
+		timer_delete(&acb->selto_timer);
 
 	adapter_uninit_chip(acb);
 	adapter_remove_and_free_all_devices(acb);
diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 59f2775..1bd42f7 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -310,7 +310,7 @@ efct_fw_reset(struct efct *efct)
 	 * during attach.
 	 */
 	if (timer_pending(&efct->xport->stats_timer))
-		del_timer(&efct->xport->stats_timer);
+		timer_delete(&efct->xport->stats_timer);
 
 	if (efct_hw_reset(&efct->hw, EFCT_HW_RESET_FIRMWARE)) {
 		efc_log_info(efct, "failed to reset firmware\n");
diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index cf4dced..2aca60f 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -508,7 +508,7 @@ efct_xport_detach(struct efct_xport *xport)
 
 	/*Shutdown FC Statistics timer*/
 	if (timer_pending(&xport->stats_timer))
-		del_timer(&xport->stats_timer);
+		timer_delete(&xport->stats_timer);
 
 	efct_hw_teardown(&efct->hw);
 
diff --git a/drivers/scsi/elx/libefc/efc_fabric.c b/drivers/scsi/elx/libefc/efc_fabric.c
index 9661eea..cf7e738 100644
--- a/drivers/scsi/elx/libefc/efc_fabric.c
+++ b/drivers/scsi/elx/libefc/efc_fabric.c
@@ -888,7 +888,7 @@ gidpt_delay_timer_cb(struct timer_list *t)
 {
 	struct efc_node *node = from_timer(node, t, gidpt_delay_timer);
 
-	del_timer(&node->gidpt_delay_timer);
+	timer_delete(&node->gidpt_delay_timer);
 
 	efc_node_post_event(node, EFC_EVT_GIDPT_DELAY_EXPIRED, NULL);
 }
diff --git a/drivers/scsi/elx/libefc/efc_node.c b/drivers/scsi/elx/libefc/efc_node.c
index a1b4ce6..f17e052 100644
--- a/drivers/scsi/elx/libefc/efc_node.c
+++ b/drivers/scsi/elx/libefc/efc_node.c
@@ -149,7 +149,7 @@ efc_node_free(struct efc_node *node)
 
 	/* if the gidpt_delay_timer is still running, then delete it */
 	if (timer_pending(&node->gidpt_delay_timer))
-		del_timer(&node->gidpt_delay_timer);
+		timer_delete(&node->gidpt_delay_timer);
 
 	xa_erase(&nport->lookup, node->rnode.fc_id);
 
diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 0cea5f3..04a07fe 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -439,7 +439,7 @@ static void esas2r_adapter_power_down(struct esas2r_adapter *a,
 	if ((test_bit(AF2_INIT_DONE, &a->flags2))
 	    &&  (!test_bit(AF_DEGRADED_MODE, &a->flags))) {
 		if (!power_management) {
-			del_timer_sync(&a->timer);
+			timer_delete_sync(&a->timer);
 			tasklet_kill(&a->tasklet);
 		}
 		esas2r_power_down(a);
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 038e385..b911fdb 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1013,7 +1013,7 @@ static void fcoe_if_destroy(struct fc_lport *lport)
 	fc_lport_destroy(lport);
 
 	/* Stop the transmit retry timer */
-	del_timer_sync(&port->timer);
+	timer_delete_sync(&port->timer);
 
 	/* Free existing transmit skbs */
 	fcoe_clean_pending_queue(lport);
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 5c8d1ba..56d2705 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -302,7 +302,7 @@ void fcoe_ctlr_destroy(struct fcoe_ctlr *fip)
 	fcoe_ctlr_set_state(fip, FIP_ST_DISABLED);
 	fcoe_ctlr_reset_fcfs(fip);
 	mutex_unlock(&fip->ctlr_mutex);
-	del_timer_sync(&fip->timer);
+	timer_delete_sync(&fip->timer);
 	cancel_work_sync(&fip->timer_work);
 }
 EXPORT_SYMBOL(fcoe_ctlr_destroy);
@@ -478,7 +478,7 @@ EXPORT_SYMBOL(fcoe_ctlr_link_up);
 static void fcoe_ctlr_reset(struct fcoe_ctlr *fip)
 {
 	fcoe_ctlr_reset_fcfs(fip);
-	del_timer(&fip->timer);
+	timer_delete(&fip->timer);
 	fip->ctlr_ka_time = 0;
 	fip->port_ka_time = 0;
 	fip->sol_time = 0;
diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 4c6bbf4..c2b6f4e 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -394,7 +394,7 @@ void fnic_del_fabric_timer_sync(struct fnic *fnic)
 {
 	fnic->iport.fabric.del_timer_inprogress = 1;
 	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-	del_timer_sync(&fnic->iport.fabric.retry_timer);
+	timer_delete_sync(&fnic->iport.fabric.retry_timer);
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 	fnic->iport.fabric.del_timer_inprogress = 0;
 }
@@ -404,7 +404,7 @@ void fnic_del_tport_timer_sync(struct fnic *fnic,
 {
 	tport->del_timer_inprogress = 1;
 	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-	del_timer_sync(&tport->retry_timer);
+	timer_delete_sync(&tport->retry_timer);
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 	tport->del_timer_inprogress = 0;
 }
@@ -3617,7 +3617,7 @@ static void fdls_process_fdmi_plogi_rsp(struct fnic_iport_s *iport,
 	fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_plogi);
 
 	if (ntoh24(fchdr->fh_s_id) == FC_FID_MGMT_SERV) {
-		del_timer_sync(&iport->fabric.fdmi_timer);
+		timer_delete_sync(&iport->fabric.fdmi_timer);
 		iport->fabric.fdmi_pending = 0;
 		switch (plogi_rsp->els.fl_cmd) {
 		case ELS_LS_ACC:
@@ -3686,7 +3686,7 @@ static void fdls_process_fdmi_reg_ack(struct fnic_iport_s *iport,
 		 iport->fcid);
 
 	if (!iport->fabric.fdmi_pending) {
-		del_timer_sync(&iport->fabric.fdmi_timer);
+		timer_delete_sync(&iport->fabric.fdmi_timer);
 		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "iport fcid: 0x%x: Canceling FDMI timer\n",
 					 iport->fcid);
@@ -3728,7 +3728,7 @@ static void fdls_process_fdmi_abts_rsp(struct fnic_iport_s *iport,
 		break;
 	}
 
-	del_timer_sync(&iport->fabric.fdmi_timer);
+	timer_delete_sync(&iport->fabric.fdmi_timer);
 	iport->fabric.fdmi_pending &= ~FDLS_FDMI_ABORT_PENDING;
 
 	fdls_send_fdmi_plogi(iport);
@@ -4971,7 +4971,7 @@ void fnic_fdls_link_down(struct fnic_iport_s *iport)
 	}
 
 	if ((fnic_fdmi_support == 1) && (iport->fabric.fdmi_pending > 0)) {
-		del_timer_sync(&iport->fabric.fdmi_timer);
+		timer_delete_sync(&iport->fabric.fdmi_timer);
 		iport->fabric.fdmi_pending = 0;
 	}
 
diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index 7bb8594..6e7c0b0 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -319,7 +319,7 @@ void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
 						  round_jiffies(fcs_ka_tov));
 				} else {
 					if (timer_pending(&fnic->fcs_ka_timer))
-						del_timer_sync(&fnic->fcs_ka_timer);
+						timer_delete_sync(&fnic->fcs_ka_timer);
 				}
 
 				if (fka_has_changed) {
@@ -497,7 +497,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 
 		oxid = FNIC_STD_GET_OX_ID(fchdr);
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
-		del_timer_sync(&fnic->retry_fip_timer);
+		timer_delete_sync(&fnic->retry_fip_timer);
 
 		if ((be16_to_cpu(flogi_rsp->fip.fip_dl_len) == FIP_FLOGI_LEN)
 		    && (flogi_rsp->rsp_desc.flogi.els.fl_cmd == ELS_LS_ACC)) {
@@ -580,10 +580,10 @@ void fnic_common_fip_cleanup(struct fnic *fnic)
 
 	iport->fip.state = FDLS_FIP_INIT;
 
-	del_timer_sync(&fnic->retry_fip_timer);
-	del_timer_sync(&fnic->fcs_ka_timer);
-	del_timer_sync(&fnic->enode_ka_timer);
-	del_timer_sync(&fnic->vn_ka_timer);
+	timer_delete_sync(&fnic->retry_fip_timer);
+	timer_delete_sync(&fnic->fcs_ka_timer);
+	timer_delete_sync(&fnic->enode_ka_timer);
+	timer_delete_sync(&fnic->vn_ka_timer);
 
 	if (!is_zero_ether_addr(iport->fpma))
 		vnic_dev_del_addr(fnic->vdev, iport->fpma);
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 3dd0637..9a357ff 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -1149,20 +1149,20 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_scsi_unload(fnic);
 
 	if (vnic_dev_get_intr_mode(fnic->vdev) == VNIC_DEV_INTR_MODE_MSI)
-		del_timer_sync(&fnic->notify_timer);
+		timer_delete_sync(&fnic->notify_timer);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-		del_timer_sync(&fnic->retry_fip_timer);
-		del_timer_sync(&fnic->fcs_ka_timer);
-		del_timer_sync(&fnic->enode_ka_timer);
-		del_timer_sync(&fnic->vn_ka_timer);
+		timer_delete_sync(&fnic->retry_fip_timer);
+		timer_delete_sync(&fnic->fcs_ka_timer);
+		timer_delete_sync(&fnic->enode_ka_timer);
+		timer_delete_sync(&fnic->vn_ka_timer);
 
 		fnic_free_txq(&fnic->fip_frame_queue);
 		fnic_fcoe_reset_vlans(fnic);
 	}
 
 	if ((fnic_fdmi_support == 1) && (fnic->iport.fabric.fdmi_pending > 0))
-		del_timer_sync(&fnic->iport.fabric.fdmi_timer);
+		timer_delete_sync(&fnic->iport.fabric.fdmi_timer);
 
 	fnic_stats_debugfs_remove(fnic);
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3596414..5cb1d3d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1548,7 +1548,7 @@ void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba)
 	 * which is also only used for v1/v2 hw to skip it for v3 hw
 	 */
 	if (hisi_hba->hw->sht)
-		del_timer_sync(&hisi_hba->timer);
+		timer_delete_sync(&hisi_hba->timer);
 
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 }
@@ -2363,7 +2363,7 @@ void hisi_sas_free(struct hisi_hba *hisi_hba)
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		struct hisi_sas_phy *phy = &hisi_hba->phy[i];
 
-		del_timer_sync(&phy->timer);
+		timer_delete_sync(&phy->timer);
 	}
 
 	if (hisi_hba->wq)
@@ -2625,7 +2625,7 @@ void hisi_sas_remove(struct platform_device *pdev)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct Scsi_Host *shost = sha->shost;
 
-	del_timer_sync(&hisi_hba->timer);
+	timer_delete_sync(&hisi_hba->timer);
 
 	sas_unregister_ha(sha);
 	sas_remove_host(shost);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 04ee027..a1fc400 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2372,18 +2372,18 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case STAT_IO_COMPLETE:
 		/* internal abort command complete */
 		ts->stat = TMF_RESP_FUNC_SUCC;
-		del_timer_sync(&slot->internal_abort_timer);
+		timer_delete_sync(&slot->internal_abort_timer);
 		goto out;
 	case STAT_IO_NO_DEVICE:
 		ts->stat = TMF_RESP_FUNC_COMPLETE;
-		del_timer_sync(&slot->internal_abort_timer);
+		timer_delete_sync(&slot->internal_abort_timer);
 		goto out;
 	case STAT_IO_NOT_VALID:
 		/* abort single io, controller don't find
 		 * the io need to abort
 		 */
 		ts->stat = TMF_RESP_FUNC_FAILED;
-		del_timer_sync(&slot->internal_abort_timer);
+		timer_delete_sync(&slot->internal_abort_timer);
 		goto out;
 	default:
 		break;
@@ -2654,7 +2654,7 @@ static int phy_up_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 	if (is_sata_phy_v2_hw(hisi_hba, phy_no))
 		goto end;
 
-	del_timer(&phy->timer);
+	timer_delete(&phy->timer);
 
 	if (phy_no == 8) {
 		u32 port_state = hisi_sas_read32(hisi_hba, PORT_STATE);
@@ -2730,7 +2730,7 @@ static int phy_down_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 	struct hisi_sas_port *port = phy->port;
 	struct device *dev = hisi_hba->dev;
 
-	del_timer(&phy->timer);
+	timer_delete(&phy->timer);
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHYCTRL_NOT_RDY_MSK, 1);
 
 	phy_state = hisi_sas_read32(hisi_hba, PHY_STATE);
@@ -2744,7 +2744,7 @@ static int phy_down_v2_hw(int phy_no, struct hisi_hba *hisi_hba)
 	if (port && !get_wideport_bitmap_v2_hw(hisi_hba, port->id))
 		if (!check_any_wideports_v2_hw(hisi_hba) &&
 				timer_pending(&hisi_hba->timer))
-			del_timer(&hisi_hba->timer);
+			timer_delete(&hisi_hba->timer);
 
 	txid_auto = hisi_sas_phy_read32(hisi_hba, phy_no, TXID_AUTO);
 	hisi_sas_phy_write32(hisi_hba, phy_no, TXID_AUTO,
@@ -3204,7 +3204,7 @@ static irqreturn_t sata_int_v2_hw(int irq_no, void *p)
 	u8 attached_sas_addr[SAS_ADDR_SIZE] = {0};
 	int phy_no, offset;
 
-	del_timer(&phy->timer);
+	timer_delete(&phy->timer);
 
 	phy_no = sas_phy->id;
 	initial_fis = &hisi_hba->initial_fis[phy_no];
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 095bbf8..2684d64 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1609,7 +1609,7 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	phy->port_id = port_id;
 	spin_lock(&phy->lock);
 	/* Delete timer and set phy_attached atomically */
-	del_timer(&phy->timer);
+	timer_delete(&phy->timer);
 	phy->phy_attached = 1;
 	spin_unlock(&phy->lock);
 
@@ -1643,7 +1643,7 @@ static irqreturn_t phy_down_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 	atomic_inc(&phy->down_cnt);
 
-	del_timer(&phy->timer);
+	timer_delete(&phy->timer);
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHYCTRL_NOT_RDY_MSK, 1);
 
 	phy_state = hisi_sas_read32(hisi_hba, PHY_STATE);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 773ec2f..4c493b0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1110,7 +1110,7 @@ static void ibmvfc_fail_request(struct ibmvfc_event *evt, int error_code)
 	} else
 		evt->xfer_iu->mad_common.status = cpu_to_be16(IBMVFC_MAD_DRIVER_FAILED);
 
-	del_timer(&evt->timer);
+	timer_delete(&evt->timer);
 }
 
 /**
@@ -1754,7 +1754,7 @@ static int ibmvfc_send_event(struct ibmvfc_event *evt,
 		atomic_set(&evt->active, 0);
 		list_del(&evt->queue_list);
 		spin_unlock_irqrestore(&evt->queue->l_lock, flags);
-		del_timer(&evt->timer);
+		timer_delete(&evt->timer);
 
 		/* If send_crq returns H_CLOSED, return SCSI_MLQUEUE_HOST_BUSY.
 		 * Firmware will send a CRQ with a transport event (0xFF) to
@@ -3832,7 +3832,7 @@ static void ibmvfc_tasklet(void *data)
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 
 	list_for_each_entry_safe(evt, temp, &evt_doneq, queue_list) {
-		del_timer(&evt->timer);
+		timer_delete(&evt->timer);
 		list_del(&evt->queue_list);
 		ibmvfc_trc_end(evt);
 		evt->done(evt);
@@ -3938,7 +3938,7 @@ static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 	spin_unlock_irqrestore(scrq->q_lock, flags);
 
 	list_for_each_entry_safe(evt, temp, &evt_doneq, queue_list) {
-		del_timer(&evt->timer);
+		timer_delete(&evt->timer);
 		list_del(&evt->queue_list);
 		ibmvfc_trc_end(evt);
 		evt->done(evt);
@@ -4542,7 +4542,7 @@ static void ibmvfc_tgt_adisc_done(struct ibmvfc_event *evt)
 
 	vhost->discovery_threads--;
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
-	del_timer(&tgt->timer);
+	timer_delete(&tgt->timer);
 
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
@@ -4741,7 +4741,7 @@ static void ibmvfc_tgt_adisc(struct ibmvfc_target *tgt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	if (ibmvfc_send_event(evt, vhost, IBMVFC_ADISC_PLUS_CANCEL_TIMEOUT)) {
 		vhost->discovery_threads--;
-		del_timer(&tgt->timer);
+		timer_delete(&tgt->timer);
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
@@ -5519,7 +5519,7 @@ static void ibmvfc_tgt_add_rport(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);
 		spin_unlock_irqrestore(vhost->host->host_lock, flags);
 		fc_remote_port_delete(rport);
-		del_timer_sync(&tgt->timer);
+		timer_delete_sync(&tgt->timer);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 		return;
 	} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
@@ -5672,7 +5672,7 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 				spin_unlock_irqrestore(vhost->host->host_lock, flags);
 				if (rport)
 					fc_remote_port_delete(rport);
-				del_timer_sync(&tgt->timer);
+				timer_delete_sync(&tgt->timer);
 				kref_put(&tgt->kref, ibmvfc_release_tgt);
 				return;
 			} else if (tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 16a1aac..d65a458 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -789,7 +789,7 @@ static void purge_requests(struct ibmvscsi_host_data *hostdata, int error_code)
 	while (!list_empty(&hostdata->sent)) {
 		evt = list_first_entry(&hostdata->sent, struct srp_event_struct, list);
 		list_del(&evt->list);
-		del_timer(&evt->timer);
+		timer_delete(&evt->timer);
 
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 		if (evt->cmnd) {
@@ -944,7 +944,7 @@ static int ibmvscsi_send_srp_event(struct srp_event_struct *evt_struct,
 			       be64_to_cpu(crq_as_u64[1]));
 	if (rc != 0) {
 		list_del(&evt_struct->list);
-		del_timer(&evt_struct->timer);
+		timer_delete(&evt_struct->timer);
 
 		/* If send_crq returns H_CLOSED, return SCSI_MLQUEUE_HOST_BUSY.
 		 * Firmware will send a CRQ with a transport event (0xFF) to
@@ -1840,7 +1840,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 		atomic_add(be32_to_cpu(evt_struct->xfer_iu->srp.rsp.req_lim_delta),
 			   &hostdata->request_limit);
 
-	del_timer(&evt_struct->timer);
+	timer_delete(&evt_struct->timer);
 
 	if ((crq->status != VIOSRP_OK && crq->status != VIOSRP_OK2) && evt_struct->cmnd)
 		evt_struct->cmnd->result = DID_ERROR << 16;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3bfafd4..d89135f 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -873,7 +873,7 @@ static void ipr_fail_all_ops(struct ipr_ioa_cfg *ioa_cfg)
 
 			ipr_trc_hook(ipr_cmd, IPR_TRACE_FINISH,
 				     IPR_IOASC_IOA_WAS_RESET);
-			del_timer(&ipr_cmd->timer);
+			timer_delete(&ipr_cmd->timer);
 			ipr_cmd->done(ipr_cmd);
 		}
 		spin_unlock(&hrrq->_lock);
@@ -5347,7 +5347,7 @@ static irqreturn_t ipr_handle_other_interrupt(struct ipr_ioa_cfg *ioa_cfg,
 				writel(IPR_PCII_IPL_STAGE_CHANGE, ioa_cfg->regs.clr_interrupt_reg);
 				int_reg = readl(ioa_cfg->regs.sense_interrupt_reg) & ~int_mask_reg;
 				list_del(&ioa_cfg->reset_cmd->queue);
-				del_timer(&ioa_cfg->reset_cmd->timer);
+				timer_delete(&ioa_cfg->reset_cmd->timer);
 				ipr_reset_ioa_job(ioa_cfg->reset_cmd);
 				return IRQ_HANDLED;
 			}
@@ -5362,7 +5362,7 @@ static irqreturn_t ipr_handle_other_interrupt(struct ipr_ioa_cfg *ioa_cfg,
 		int_reg = readl(ioa_cfg->regs.sense_interrupt_reg);
 
 		list_del(&ioa_cfg->reset_cmd->queue);
-		del_timer(&ioa_cfg->reset_cmd->timer);
+		timer_delete(&ioa_cfg->reset_cmd->timer);
 		ipr_reset_ioa_job(ioa_cfg->reset_cmd);
 	} else if ((int_reg & IPR_PCII_HRRQ_UPDATED) == int_reg) {
 		if (ioa_cfg->clear_isr) {
@@ -5481,7 +5481,7 @@ static int ipr_iopoll(struct irq_poll *iop, int budget)
 
 	list_for_each_entry_safe(ipr_cmd, temp, &doneq, queue) {
 		list_del(&ipr_cmd->queue);
-		del_timer(&ipr_cmd->timer);
+		timer_delete(&ipr_cmd->timer);
 		ipr_cmd->fast_done(ipr_cmd);
 	}
 
@@ -5550,7 +5550,7 @@ static irqreturn_t ipr_isr(int irq, void *devp)
 	spin_unlock_irqrestore(hrrq->lock, hrrq_flags);
 	list_for_each_entry_safe(ipr_cmd, temp, &doneq, queue) {
 		list_del(&ipr_cmd->queue);
-		del_timer(&ipr_cmd->timer);
+		timer_delete(&ipr_cmd->timer);
 		ipr_cmd->fast_done(ipr_cmd);
 	}
 	return rc;
@@ -5600,7 +5600,7 @@ static irqreturn_t ipr_isr_mhrrq(int irq, void *devp)
 
 	list_for_each_entry_safe(ipr_cmd, temp, &doneq, queue) {
 		list_del(&ipr_cmd->queue);
-		del_timer(&ipr_cmd->timer);
+		timer_delete(&ipr_cmd->timer);
 		ipr_cmd->fast_done(ipr_cmd);
 	}
 	return rc;
diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 35589b6..c108b5b 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -1271,22 +1271,22 @@ void isci_host_deinit(struct isci_host *ihost)
 	/* Cancel any/all outstanding port timers */
 	for (i = 0; i < ihost->logical_port_entries; i++) {
 		struct isci_port *iport = &ihost->ports[i];
-		del_timer_sync(&iport->timer.timer);
+		timer_delete_sync(&iport->timer.timer);
 	}
 
 	/* Cancel any/all outstanding phy timers */
 	for (i = 0; i < SCI_MAX_PHYS; i++) {
 		struct isci_phy *iphy = &ihost->phys[i];
-		del_timer_sync(&iphy->sata_timer.timer);
+		timer_delete_sync(&iphy->sata_timer.timer);
 	}
 
-	del_timer_sync(&ihost->port_agent.timer.timer);
+	timer_delete_sync(&ihost->port_agent.timer.timer);
 
-	del_timer_sync(&ihost->power_control.timer.timer);
+	timer_delete_sync(&ihost->power_control.timer.timer);
 
-	del_timer_sync(&ihost->timer.timer);
+	timer_delete_sync(&ihost->timer.timer);
 
-	del_timer_sync(&ihost->phy_timer.timer);
+	timer_delete_sync(&ihost->phy_timer.timer);
 }
 
 static void __iomem *scu_base(struct isci_host *isci_host)
diff --git a/drivers/scsi/isci/isci.h b/drivers/scsi/isci/isci.h
index f6a8fe2..d827e49 100644
--- a/drivers/scsi/isci/isci.h
+++ b/drivers/scsi/isci/isci.h
@@ -481,9 +481,9 @@ irqreturn_t isci_error_isr(int vec, void *data);
 
 /*
  * Each timer is associated with a cancellation flag that is set when
- * del_timer() is called and checked in the timer callback function. This
- * is needed since del_timer_sync() cannot be called with sci_lock held.
- * For deinit however, del_timer_sync() is used without holding the lock.
+ * timer_delete() is called and checked in the timer callback function. This
+ * is needed since timer_delete_sync() cannot be called with sci_lock held.
+ * For deinit however, timer_delete_sync() is used without holding the lock.
  */
 struct sci_timer {
 	struct timer_list	timer;
@@ -506,7 +506,7 @@ static inline void sci_mod_timer(struct sci_timer *tmr, unsigned long msec)
 static inline void sci_del_timer(struct sci_timer *tmr)
 {
 	tmr->cancel = true;
-	del_timer(&tmr->timer);
+	timer_delete(&tmr->timer);
 }
 
 struct sci_base_state_machine {
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index fd1ef06..e705c30 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1329,7 +1329,7 @@ static int fc_lun_reset(struct fc_lport *lport, struct fc_fcp_pkt *fsp,
 	fsp->state |= FC_SRB_COMPL;
 	spin_unlock_bh(&fsp->scsi_pkt_lock);
 
-	del_timer_sync(&fsp->timer);
+	timer_delete_sync(&fsp->timer);
 
 	spin_lock_bh(&fsp->scsi_pkt_lock);
 	if (fsp->seq_ptr) {
@@ -1961,7 +1961,7 @@ static void fc_io_compl(struct fc_fcp_pkt *fsp)
 	fsp->state |= FC_SRB_COMPL;
 	if (!(fsp->state & FC_SRB_FCP_PROCESSING_TMO)) {
 		spin_unlock_bh(&fsp->scsi_pkt_lock);
-		del_timer_sync(&fsp->timer);
+		timer_delete_sync(&fsp->timer);
 		spin_lock_bh(&fsp->scsi_pkt_lock);
 	}
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 2b1bf99..1ddaf72 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1945,7 +1945,7 @@ static int iscsi_exec_task_mgmt_fn(struct iscsi_conn *conn,
 				 session->tmf_state != TMF_QUEUED);
 	if (signal_pending(current))
 		flush_signals(current);
-	del_timer_sync(&session->tmf_timer);
+	timer_delete_sync(&session->tmf_timer);
 
 	mutex_lock(&session->eh_mutex);
 	spin_lock_bh(&session->frwd_lock);
@@ -3247,7 +3247,7 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 
 	iscsi_remove_conn(cls_conn);
 
-	del_timer_sync(&conn->transport_timer);
+	timer_delete_sync(&conn->transport_timer);
 
 	mutex_lock(&session->eh_mutex);
 	spin_lock_bh(&session->frwd_lock);
@@ -3411,7 +3411,7 @@ void iscsi_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
 	conn->stop_stage = flag;
 	spin_unlock_bh(&session->frwd_lock);
 
-	del_timer_sync(&conn->transport_timer);
+	timer_delete_sync(&conn->transport_timer);
 	iscsi_suspend_tx(conn);
 
 	spin_lock_bh(&session->frwd_lock);
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 2b8004e..869b5d4 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -89,7 +89,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
 
 		if (res) {
-			del_timer_sync(&task->slow_task->timer);
+			timer_delete_sync(&task->slow_task->timer);
 			pr_notice("executing SMP task failed:%d\n", res);
 			break;
 		}
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 55ce789..feb2461 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -859,7 +859,7 @@ EXPORT_SYMBOL_GPL(sas_bios_param);
 
 void sas_task_internal_done(struct sas_task *task)
 {
-	del_timer(&task->slow_task->timer);
+	timer_delete(&task->slow_task->timer);
 	complete(&task->slow_task->completion);
 }
 
@@ -911,7 +911,7 @@ static int sas_execute_internal_abort(struct domain_device *device,
 
 		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
 		if (res) {
-			del_timer_sync(&task->slow_task->timer);
+			timer_delete_sync(&task->slow_task->timer);
 			pr_err("Executing internal abort failed %016llx (%d)\n",
 			       SAS_ADDR(device->sas_addr), res);
 			break;
@@ -1010,7 +1010,7 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 
 		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
 		if (res) {
-			del_timer_sync(&task->slow_task->timer);
+			timer_delete_sync(&task->slow_task->timer);
 			pr_err("executing TMF task failed %016llx (%d)\n",
 			       SAS_ADDR(device->sas_addr), res);
 			break;
@@ -1180,7 +1180,7 @@ void sas_task_abort(struct sas_task *task)
 
 		if (!slow)
 			return;
-		if (!del_timer(&slow->timer))
+		if (!timer_delete(&slow->timer))
 			return;
 		slow->timer.function(&slow->timer);
 		return;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 0d0213b..397216f 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2578,7 +2578,7 @@ lpfc_poll_store(struct device *dev, struct device_attribute *attr,
 	    (old_val & DISABLE_FCP_RING_INT))
 	{
 		spin_unlock_irq(&phba->hbalock);
-		del_timer(&phba->fcp_poll_timer);
+		timer_delete(&phba->fcp_poll_timer);
 		spin_lock_irq(&phba->hbalock);
 		if (lpfc_readl(phba->HCregaddr, &creg_val)) {
 			spin_unlock_irq(&phba->hbalock);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index e08b48b..375a879 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4333,7 +4333,7 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
 
 	if (!test_and_clear_bit(NLP_DELAY_TMO, &nlp->nlp_flag))
 		return;
-	del_timer_sync(&nlp->nlp_delayfunc);
+	timer_delete_sync(&nlp->nlp_delayfunc);
 	nlp->nlp_last_elscmd = 0;
 	if (!list_empty(&nlp->els_retry_evt.evt_listp)) {
 		list_del_init(&nlp->els_retry_evt.evt_listp);
@@ -4431,7 +4431,7 @@ lpfc_els_retry_delay_handler(struct lpfc_nodelist *ndlp)
 	 * firing and before processing the timer, cancel the
 	 * nlp_delayfunc.
 	 */
-	del_timer_sync(&ndlp->nlp_delayfunc);
+	timer_delete_sync(&ndlp->nlp_delayfunc);
 	retry = ndlp->nlp_retry;
 	ndlp->nlp_retry = 0;
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 8ca590e..179be6c 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1228,7 +1228,7 @@ lpfc_linkdown_port(struct lpfc_vport *vport)
 
 	/* Stop delayed Nport discovery */
 	clear_bit(FC_DISC_DELAYED, &vport->fc_flag);
-	del_timer_sync(&vport->delayed_disc_tmo);
+	timer_delete_sync(&vport->delayed_disc_tmo);
 
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
 	    vport->port_type == LPFC_PHYSICAL_PORT &&
@@ -1418,7 +1418,7 @@ lpfc_linkup(struct lpfc_hba *phba)
 
 	/* Unblock fabric iocbs if they are blocked */
 	clear_bit(FABRIC_COMANDS_BLOCKED, &phba->bit_flags);
-	del_timer_sync(&phba->fabric_block_timer);
+	timer_delete_sync(&phba->fabric_block_timer);
 
 	vports = lpfc_create_vport_work_array(phba);
 	if (vports != NULL)
@@ -5010,7 +5010,7 @@ lpfc_can_disctmo(struct lpfc_vport *vport)
 	if (test_bit(FC_DISC_TMO, &vport->fc_flag) ||
 	    timer_pending(&vport->fc_disctmo)) {
 		clear_bit(FC_DISC_TMO, &vport->fc_flag);
-		del_timer_sync(&vport->fc_disctmo);
+		timer_delete_sync(&vport->fc_disctmo);
 		spin_lock_irqsave(&vport->work_port_lock, iflags);
 		vport->work_port_events &= ~WORKER_DISC_TMO;
 		spin_unlock_irqrestore(&vport->work_port_lock, iflags);
@@ -5501,7 +5501,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	clear_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 
 	ndlp->nlp_last_elscmd = 0;
-	del_timer_sync(&ndlp->nlp_delayfunc);
+	timer_delete_sync(&ndlp->nlp_delayfunc);
 
 	list_del_init(&ndlp->els_retry_evt.evt_listp);
 	list_del_init(&ndlp->dev_loss_evt.evt_listp);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7238608..9002165 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3120,8 +3120,8 @@ lpfc_cleanup(struct lpfc_vport *vport)
 void
 lpfc_stop_vport_timers(struct lpfc_vport *vport)
 {
-	del_timer_sync(&vport->els_tmofunc);
-	del_timer_sync(&vport->delayed_disc_tmo);
+	timer_delete_sync(&vport->els_tmofunc);
+	timer_delete_sync(&vport->delayed_disc_tmo);
 	lpfc_can_disctmo(vport);
 	return;
 }
@@ -3140,7 +3140,7 @@ __lpfc_sli4_stop_fcf_redisc_wait_timer(struct lpfc_hba *phba)
 	phba->fcf.fcf_flag &= ~FCF_REDISC_PEND;
 
 	/* Now, try to stop the timer */
-	del_timer(&phba->fcf.redisc_wait);
+	timer_delete(&phba->fcf.redisc_wait);
 }
 
 /**
@@ -3302,12 +3302,12 @@ lpfc_stop_hba_timers(struct lpfc_hba *phba)
 		lpfc_stop_vport_timers(phba->pport);
 	cancel_delayed_work_sync(&phba->eq_delay_work);
 	cancel_delayed_work_sync(&phba->idle_stat_delay_work);
-	del_timer_sync(&phba->sli.mbox_tmo);
-	del_timer_sync(&phba->fabric_block_timer);
-	del_timer_sync(&phba->eratt_poll);
-	del_timer_sync(&phba->hb_tmofunc);
+	timer_delete_sync(&phba->sli.mbox_tmo);
+	timer_delete_sync(&phba->fabric_block_timer);
+	timer_delete_sync(&phba->eratt_poll);
+	timer_delete_sync(&phba->hb_tmofunc);
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		del_timer_sync(&phba->rrq_tmr);
+		timer_delete_sync(&phba->rrq_tmr);
 		clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
 	}
 	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
@@ -3316,7 +3316,7 @@ lpfc_stop_hba_timers(struct lpfc_hba *phba)
 	switch (phba->pci_dev_grp) {
 	case LPFC_PCI_DEV_LP:
 		/* Stop any LightPulse device specific driver timers */
-		del_timer_sync(&phba->fcp_poll_timer);
+		timer_delete_sync(&phba->fcp_poll_timer);
 		break;
 	case LPFC_PCI_DEV_OC:
 		/* Stop any OneConnect device specific driver timers */
@@ -12761,7 +12761,7 @@ static void __lpfc_cpuhp_remove(struct lpfc_hba *phba)
 	 * timer. Wait for the poll timer to retire.
 	 */
 	synchronize_rcu();
-	del_timer_sync(&phba->cpuhp_poll_timer);
+	timer_delete_sync(&phba->cpuhp_poll_timer);
 }
 
 static void lpfc_cpuhp_remove(struct lpfc_hba *phba)
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index f0158fc..9edf80b 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5488,7 +5488,7 @@ void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport)
 	struct lpfc_vmid *cur;
 
 	if (vport->port_type == LPFC_PHYSICAL_PORT)
-		del_timer_sync(&vport->phba->inactive_vmid_poll);
+		timer_delete_sync(&vport->phba->inactive_vmid_poll);
 
 	kfree(vport->qfpa_res);
 	kfree(vport->vmid_priority.vmid_range);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4e0d48f..6574f9e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -5041,7 +5041,7 @@ lpfc_sli_brdkill(struct lpfc_hba *phba)
 			return 1;
 	}
 
-	del_timer_sync(&psli->mbox_tmo);
+	timer_delete_sync(&psli->mbox_tmo);
 	if (ha_copy & HA_ERATT) {
 		writel(HA_ERATT, phba->HAregaddr);
 		phba->pport->stopped = 1;
@@ -12076,7 +12076,7 @@ lpfc_sli_hba_down(struct lpfc_hba *phba)
 	local_bh_enable();
 
 	/* Return any active mbox cmds */
-	del_timer_sync(&psli->mbox_tmo);
+	timer_delete_sync(&psli->mbox_tmo);
 
 	spin_lock_irqsave(&phba->pport->work_port_lock, flags);
 	phba->pport->work_port_events &= ~WORKER_MBOX_TMO;
@@ -13802,7 +13802,7 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 				phba->sli.mbox_active = NULL;
 				spin_unlock_irqrestore(&phba->hbalock, iflag);
 				phba->last_completion_time = jiffies;
-				del_timer(&phba->sli.mbox_tmo);
+				timer_delete(&phba->sli.mbox_tmo);
 				if (pmb->mbox_cmpl) {
 					lpfc_sli_pcimem_bcopy(mbox, pmbox,
 							MAILBOX_CMD_SIZE);
@@ -14302,7 +14302,7 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 
 	/* Reset heartbeat timer */
 	phba->last_completion_time = jiffies;
-	del_timer(&phba->sli.mbox_tmo);
+	timer_delete(&phba->sli.mbox_tmo);
 
 	/* Move mbox data to caller's mailbox region, do endian swapping */
 	if (pmb->mbox_cmpl && mbox)
@@ -15689,7 +15689,7 @@ static inline void lpfc_sli4_remove_from_poll_list(struct lpfc_queue *eq)
 	synchronize_rcu();
 
 	if (list_empty(&phba->poll_list))
-		del_timer_sync(&phba->cpuhp_poll_timer);
+		timer_delete_sync(&phba->cpuhp_poll_timer);
 }
 
 void lpfc_sli4_cleanup_poll_list(struct lpfc_hba *phba)
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 3ba837b..d533a8a 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3951,7 +3951,7 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
 	}
 
 
-	del_timer_sync(&timeout.timer);
+	timer_delete_sync(&timeout.timer);
 	destroy_timer_on_stack(&timeout.timer);
 
 	mutex_unlock(&raid_dev->sysfs_mtx);
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index c509440..1f2cd15 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -703,7 +703,7 @@ lld_ioctl(mraid_mmadp_t *adp, uioc_t *kioc)
 	 */
 	wait_event(wait_q, (kioc->status != -ENODATA));
 	if (timeout.timer.function) {
-		del_timer_sync(&timeout.timer);
+		timer_delete_sync(&timeout.timer);
 		destroy_timer_on_stack(&timeout.timer);
 	}
 
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 28c7586..c20447b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6521,7 +6521,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 
 fail_start_watchdog:
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 fail_get_ld_pd_list:
 	instance->instancet->disable_intr(instance);
 	megasas_destroy_irqs(instance);
@@ -7603,7 +7603,7 @@ fail_io_attach:
 	megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = NULL;
 
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 
 	instance->instancet->disable_intr(instance);
 	megasas_destroy_irqs(instance);
@@ -7743,7 +7743,7 @@ megasas_suspend(struct device *dev)
 
 	/* Shutdown SR-IOV heartbeat timer */
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 
 	/* Stop the FW fault detection watchdog */
 	if (instance->adapter_type != MFI_SERIES)
@@ -7907,7 +7907,7 @@ megasas_resume(struct device *dev)
 
 fail_start_watchdog:
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 fail_init_mfi:
 	megasas_free_ctrl_dma_buffers(instance);
 	megasas_free_ctrl_mem(instance);
@@ -7971,7 +7971,7 @@ static void megasas_detach_one(struct pci_dev *pdev)
 
 	/* Shutdown SR-IOV heartbeat timer */
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 
 	/* Stop the FW fault detection watchdog */
 	if (instance->adapter_type != MFI_SERIES)
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 1eec23d..721860c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4969,7 +4969,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
 	}
 
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
-		del_timer_sync(&instance->sriov_heartbeat_timer);
+		timer_delete_sync(&instance->sriov_heartbeat_timer);
 	set_bit(MEGASAS_FUSION_IN_RESET, &instance->reset_flags);
 	set_bit(MEGASAS_FUSION_OCR_NOT_POSSIBLE, &instance->reset_flags);
 	atomic_set(&instance->adprecovery, MEGASAS_ADPRESET_SM_POLLING);
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index c4592de..52ac102 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -976,7 +976,7 @@ static u32 mvs_is_sig_fis_received(u32 irq_status)
 static void mvs_sig_remove_timer(struct mvs_phy *phy)
 {
 	if (phy->timer.function)
-		del_timer(&phy->timer);
+		timer_delete(&phy->timer);
 	phy->timer.function = NULL;
 }
 
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 3ba5391..e0aeb20 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -495,7 +495,7 @@ static void pmcraid_clr_trans_op(
 	}
 
 	if (pinstance->reset_cmd != NULL) {
-		del_timer(&pinstance->reset_cmd->timer);
+		timer_delete(&pinstance->reset_cmd->timer);
 		spin_lock_irqsave(
 			pinstance->host->host_lock, lock_flags);
 		pinstance->reset_cmd->cmd_done(pinstance->reset_cmd);
@@ -1999,7 +1999,7 @@ static void pmcraid_fail_outstanding_cmds(struct pmcraid_instance *pinstance)
 			cpu_to_le32(PMCRAID_DRIVER_ILID);
 
 		/* In case the command timer is still running */
-		del_timer(&cmd->timer);
+		timer_delete(&cmd->timer);
 
 		/* If this is an IO command, complete it by invoking scsi_done
 		 * function. If this is one of the internal commands other
@@ -3982,7 +3982,7 @@ static void pmcraid_tasklet_function(unsigned long instance)
 		list_del(&cmd->free_list);
 		spin_unlock_irqrestore(&pinstance->pending_pool_lock,
 					pending_lock_flags);
-		del_timer(&cmd->timer);
+		timer_delete(&cmd->timer);
 		atomic_dec(&pinstance->outstanding_cmds);
 
 		if (cmd->cmd_done == pmcraid_ioa_reset) {
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 47d74f8..078a9c8 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2454,7 +2454,7 @@ qla1280_mailbox_command(struct scsi_qla_host *ha, uint8_t mr, uint16_t *mb)
 	qla1280_debounce_register(&reg->istatus);
 
 	wait_for_completion(&wait);
-	del_timer_sync(&ha->mailbox_timer);
+	timer_delete_sync(&ha->mailbox_timer);
 
 	spin_lock_irq(ha->host->host_lock);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 79cdfec..0c2dd78 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -67,7 +67,7 @@ void qla2x00_sp_free(srb_t *sp)
 {
 	struct srb_iocb *iocb = &sp->u.iocb_cmd;
 
-	del_timer(&iocb->timer);
+	timer_delete(&iocb->timer);
 	qla2x00_rel_sp(sp);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0b41e8a..3224044 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2572,7 +2572,7 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 static void
 qla2x00_async_done(struct srb *sp, int res)
 {
-	if (del_timer(&sp->u.iocb_cmd.timer)) {
+	if (timer_delete(&sp->u.iocb_cmd.timer)) {
 		/*
 		 * Successfully cancelled the timeout handler
 		 * ref: TMR
@@ -2645,7 +2645,7 @@ static void qla2x00_els_dcmd_sp_free(srb_t *sp)
 		    elsio->u.els_logo.els_logo_pyld,
 		    elsio->u.els_logo.els_logo_pyld_dma);
 
-	del_timer(&elsio->timer);
+	timer_delete(&elsio->timer);
 	qla2x00_rel_sp(sp);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 79879c4..8b71ac0 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -20,7 +20,7 @@ void
 qla2x00_vp_stop_timer(scsi_qla_host_t *vha)
 {
 	if (vha->vp_idx && vha->timer_active) {
-		del_timer_sync(&vha->timer);
+		timer_delete_sync(&vha->timer);
 		vha->timer_active = 0;
 	}
 }
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 6b9b821..b44d134 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -401,7 +401,7 @@ qla2x00_restart_timer(scsi_qla_host_t *vha, unsigned long interval)
 static __inline__ void
 qla2x00_stop_timer(scsi_qla_host_t *vha)
 {
-	del_timer_sync(&vha->timer);
+	timer_delete_sync(&vha->timer);
 	vha->timer_active = 0;
 }
 
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 6b0e6b4..d540d66 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4021,7 +4021,7 @@ static void qla4xxx_start_timer(struct scsi_qla_host *ha,
 
 static void qla4xxx_stop_timer(struct scsi_qla_host *ha)
 {
-	del_timer_sync(&ha->timer);
+	timer_delete_sync(&ha->timer);
 	ha->timer_active = 0;
 }
 
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 0da7be4..88135fd 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -3853,7 +3853,7 @@ static void pqi_start_heartbeat_timer(struct pqi_ctrl_info *ctrl_info)
 
 static inline void pqi_stop_heartbeat_timer(struct pqi_ctrl_info *ctrl_info)
 {
-	del_timer_sync(&ctrl_info->heartbeat_timer);
+	timer_delete_sync(&ctrl_info->heartbeat_timer);
 }
 
 static void pqi_ofa_capture_event_payload(struct pqi_ctrl_info *ctrl_info,
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 212d89d..1a6eb72 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1657,7 +1657,7 @@ static int sym_detach(struct Scsi_Host *shost, struct pci_dev *pdev)
 	struct sym_hcb *np = sym_get_hcb(shost);
 	printk("%s: detaching ...\n", sym_name(np));
 
-	del_timer_sync(&np->s.timer);
+	timer_delete_sync(&np->s.timer);
 
 	/*
 	 * Reset NCR chip.
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 67bf125..da22996 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -102,7 +102,7 @@ static int agilent_82357a_send_bulk_msg(struct agilent_82357a_priv *a_priv, void
 cleanup:
 	if (timeout_msecs) {
 		if (timer_pending(&a_priv->bulk_timer))
-			del_timer_sync(&a_priv->bulk_timer);
+			timer_delete_sync(&a_priv->bulk_timer);
 	}
 	mutex_lock(&a_priv->bulk_alloc_lock);
 	if (a_priv->bulk_urb) {
@@ -169,7 +169,7 @@ static int agilent_82357a_receive_bulk_msg(struct agilent_82357a_priv *a_priv, v
 	*actual_data_length = a_priv->bulk_urb->actual_length;
 cleanup:
 	if (timeout_msecs)
-		del_timer_sync(&a_priv->bulk_timer);
+		timer_delete_sync(&a_priv->bulk_timer);
 
 	mutex_lock(&a_priv->bulk_alloc_lock);
 	if (a_priv->bulk_urb) {
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index cb77fe0..8456b97 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -109,7 +109,7 @@ void os_remove_timer(struct gpib_board *board)
 /* Removes the timeout task */
 {
 	if (timer_pending(&board->timer))
-		del_timer_sync(&board->timer);
+		timer_delete_sync(&board->timer);
 }
 
 int io_timed_out(struct gpib_board *board)
@@ -163,7 +163,7 @@ void gpib_free_pseudo_irq(struct gpib_board *board)
 {
 	atomic_set(&board->pseudo_irq.active, 0);
 
-	del_timer_sync(&board->pseudo_irq.timer);
+	timer_delete_sync(&board->pseudo_irq.timer);
 	board->pseudo_irq.handler = NULL;
 }
 EXPORT_SYMBOL(gpib_free_pseudo_irq);
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 6cca8a4..b297261 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -610,7 +610,7 @@ static void start_wait_timer(struct wait_info *winfo)
 
 static void remove_wait_timer(struct wait_info *winfo)
 {
-	del_timer_sync(&winfo->timer);
+	timer_delete_sync(&winfo->timer);
 	destroy_timer_on_stack(&winfo->timer);
 }
 
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 14f7049..9f1b992 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -136,7 +136,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 
 	retval = usb_submit_urb(ni_priv->bulk_urb, GFP_KERNEL);
 	if (retval) {
-		del_timer_sync(&ni_priv->bulk_timer);
+		timer_delete_sync(&ni_priv->bulk_timer);
 		usb_free_urb(ni_priv->bulk_urb);
 		ni_priv->bulk_urb = NULL;
 		dev_err(&usb_dev->dev, "failed to submit bulk out urb, retval=%i\n",
@@ -154,7 +154,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 		retval = ni_priv->bulk_urb->status;
 	}
 
-	del_timer_sync(&ni_priv->bulk_timer);
+	timer_delete_sync(&ni_priv->bulk_timer);
 	*actual_data_length = ni_priv->bulk_urb->actual_length;
 	mutex_lock(&ni_priv->bulk_transfer_lock);
 	usb_free_urb(ni_priv->bulk_urb);
@@ -222,7 +222,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 
 	retval = usb_submit_urb(ni_priv->bulk_urb, GFP_KERNEL);
 	if (retval) {
-		del_timer_sync(&ni_priv->bulk_timer);
+		timer_delete_sync(&ni_priv->bulk_timer);
 		usb_free_urb(ni_priv->bulk_urb);
 		ni_priv->bulk_urb = NULL;
 		dev_err(&usb_dev->dev, "failed to submit bulk in urb, retval=%i\n", retval);
@@ -256,7 +256,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 		if (ni_priv->bulk_urb->status)
 			retval = ni_priv->bulk_urb->status;
 	}
-	del_timer_sync(&ni_priv->bulk_timer);
+	timer_delete_sync(&ni_priv->bulk_timer);
 	*actual_data_length = ni_priv->bulk_urb->actual_length;
 	mutex_lock(&ni_priv->bulk_transfer_lock);
 	usb_free_urb(ni_priv->bulk_urb);
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 17fd980..2855ba2 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -781,7 +781,7 @@ static void prp_stop(struct prp_priv *priv)
 	imx_media_free_dma_buf(ic_priv->ipu_dev, &priv->underrun_buf);
 
 	/* cancel the EOF timeout timer */
-	del_timer_sync(&priv->eof_timeout_timer);
+	timer_delete_sync(&priv->eof_timeout_timer);
 
 	prp_put_ipu_resources(priv);
 }
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 3edbc57..f1d7fce 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -695,7 +695,7 @@ static void csi_idmac_stop(struct csi_priv *priv)
 	imx_media_free_dma_buf(priv->dev, &priv->underrun_buf);
 
 	/* cancel the EOF timeout timer */
-	del_timer_sync(&priv->eof_timeout_timer);
+	timer_delete_sync(&priv->eof_timeout_timer);
 
 	csi_idmac_put_ipu_resources(priv);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 64ce33c..1c9e8b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1846,7 +1846,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->res != H2C_SUCCESS)
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
-	del_timer_sync(&pmlmepriv->assoc_timer);
+	timer_delete_sync(&pmlmepriv->assoc_timer);
 
 	spin_lock_bh(&pmlmepriv->lock);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5ded183..58de0c2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -681,7 +681,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		spin_unlock_bh(&pmlmepriv->lock);
-		del_timer_sync(&pmlmepriv->scan_to_timer);
+		timer_delete_sync(&pmlmepriv->scan_to_timer);
 		spin_lock_bh(&pmlmepriv->lock);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	}
@@ -1166,7 +1166,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 			spin_unlock_bh(&pmlmepriv->lock);
 			/* s5. Cancel assoc_timer */
-			del_timer_sync(&pmlmepriv->assoc_timer);
+			timer_delete_sync(&pmlmepriv->assoc_timer);
 			spin_lock_bh(&pmlmepriv->lock);
 		} else {
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 952ce6d..3d36b6f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -412,9 +412,9 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 		return;
 
 	if (padapter->bDriverStopped) {
-		del_timer_sync(&pmlmeext->survey_timer);
-		del_timer_sync(&pmlmeext->link_timer);
-		/* del_timer_sync(&pmlmeext->ADDBA_timer); */
+		timer_delete_sync(&pmlmeext->survey_timer);
+		timer_delete_sync(&pmlmeext->link_timer);
+		/* timer_delete_sync(&pmlmeext->ADDBA_timer); */
 	}
 }
 
@@ -1390,7 +1390,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)
 		return _SUCCESS;
 
-	del_timer_sync(&pmlmeext->link_timer);
+	timer_delete_sync(&pmlmeext->link_timer);
 
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
@@ -1862,7 +1862,7 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
 		break;
 
 	case 1: /* SA Query rsp */
-		del_timer_sync(&pmlmeext->sa_query_timer);
+		timer_delete_sync(&pmlmeext->sa_query_timer);
 		break;
 	default:
 		break;
@@ -4185,7 +4185,7 @@ void start_clnt_auth(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	del_timer_sync(&pmlmeext->link_timer);
+	timer_delete_sync(&pmlmeext->link_timer);
 
 	pmlmeinfo->state &= (~WIFI_FW_AUTH_NULL);
 	pmlmeinfo->state |= WIFI_FW_AUTH_STATE;
@@ -4210,7 +4210,7 @@ void start_clnt_assoc(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	del_timer_sync(&pmlmeext->link_timer);
+	timer_delete_sync(&pmlmeext->link_timer);
 
 	pmlmeinfo->state &= (~(WIFI_FW_AUTH_NULL | WIFI_FW_AUTH_STATE));
 	pmlmeinfo->state |= (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE);
@@ -4792,7 +4792,7 @@ static void rtw_mlmeext_disconnect(struct adapter *padapter)
 
 	flush_all_cam_entry(padapter);
 
-	del_timer_sync(&pmlmeext->link_timer);
+	timer_delete_sync(&pmlmeext->link_timer);
 
 	/* pmlmepriv->LinkDetectInfo.TrafficBusyState = false; */
 	pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 0;
@@ -5268,7 +5268,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		/* rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain)); */
 
 		/* cancel link timer */
-		del_timer_sync(&pmlmeext->link_timer);
+		timer_delete_sync(&pmlmeext->link_timer);
 
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
@@ -5312,7 +5312,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		/* clear CAM */
 		flush_all_cam_entry(padapter);
 
-		del_timer_sync(&pmlmeext->link_timer);
+		timer_delete_sync(&pmlmeext->link_timer);
 
 		/* set MSR to nolink -> infra. mode */
 		/* Set_MSR(padapter, _HW_STATE_NOLINK_); */
@@ -5425,7 +5425,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	set_channel_bwmode(padapter, ch, offset, bw);
 
 	/* cancel link timer */
-	del_timer_sync(&pmlmeext->link_timer);
+	timer_delete_sync(&pmlmeext->link_timer);
 
 	start_clnt_join(padapter);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index a389ba5..895116e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1893,7 +1893,7 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		spin_unlock_bh(&ppending_recvframe_queue->lock);
 	} else {
 		spin_unlock_bh(&ppending_recvframe_queue->lock);
-		del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
+		timer_delete_sync(&preorder_ctrl->reordering_ctrl_timer);
 	}
 
 	return _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 1b72f21..1d2b53c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -158,7 +158,7 @@ u32 _rtw_free_sta_priv(struct	sta_priv *pstapriv)
 
 				for (i = 0; i < 16 ; i++) {
 					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
+					timer_delete_sync(&preorder_ctrl->reordering_ctrl_timer);
 				}
 			}
 		}
@@ -343,7 +343,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	/* _rtw_init_sta_xmit_priv(&psta->sta_xmitpriv); */
 	/* _rtw_init_sta_recv_priv(&psta->sta_recvpriv); */
 
-	del_timer_sync(&psta->addba_retry_timer);
+	timer_delete_sync(&psta->addba_retry_timer);
 
 	/* for A-MPDU Rx reordering buffer control, cancel reordering_ctrl_timer */
 	for (i = 0; i < 16 ; i++) {
@@ -354,7 +354,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 		preorder_ctrl = &psta->recvreorder_ctrl[i];
 
-		del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
+		timer_delete_sync(&preorder_ctrl->reordering_ctrl_timer);
 
 		ppending_recvframe_queue = &preorder_ctrl->pending_recvframe_queue;
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 21e9f18..8736c12 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -871,7 +871,7 @@ void sd_int_dpc(struct adapter *adapter)
 	}
 
 	if (hal->sdio_hisr & SDIO_HISR_CPWM1) {
-		del_timer_sync(&(pwrctl->pwr_rpwm_timer));
+		timer_delete_sync(&(pwrctl->pwr_rpwm_timer));
 
 		SdioLocalCmd52Read1Byte(adapter, SDIO_REG_HCPWM1_8723B);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index de48c34..0248dff 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -697,18 +697,18 @@ free_cmd_priv:
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	del_timer_sync(&padapter->mlmepriv.assoc_timer);
+	timer_delete_sync(&padapter->mlmepriv.assoc_timer);
 
-	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
+	timer_delete_sync(&padapter->mlmepriv.scan_to_timer);
 
-	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
+	timer_delete_sync(&padapter->mlmepriv.dynamic_chk_timer);
 
-	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
+	timer_delete_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
 
-	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
+	timer_delete_sync(&padapter->mlmepriv.set_scan_deny_timer);
 	rtw_clear_scan_deny(padapter);
 
-	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
+	timer_delete_sync(&padapter->recvpriv.signal_stat_timer);
 
 	/* cancel dm timer */
 	rtw_hal_dm_deinit(padapter);
diff --git a/drivers/target/iscsi/iscsi_target_erl0.c b/drivers/target/iscsi/iscsi_target_erl0.c
index 07e9cf4..f0d7eeb 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.c
+++ b/drivers/target/iscsi/iscsi_target_erl0.c
@@ -810,7 +810,7 @@ int iscsit_stop_time2retain_timer(struct iscsit_session *sess)
 	sess->time2retain_timer_flags |= ISCSI_TF_STOP;
 	spin_unlock(&se_tpg->session_lock);
 
-	del_timer_sync(&sess->time2retain_timer);
+	timer_delete_sync(&sess->time2retain_timer);
 
 	spin_lock(&se_tpg->session_lock);
 	sess->time2retain_timer_flags &= ~ISCSI_TF_RUNNING;
diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index d9a6242..e7c3c4c 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -1227,7 +1227,7 @@ void iscsit_stop_dataout_timer(struct iscsit_cmd *cmd)
 	cmd->dataout_timer_flags |= ISCSI_TF_STOP;
 	spin_unlock_bh(&cmd->dataout_timeout_lock);
 
-	del_timer_sync(&cmd->dataout_timer);
+	timer_delete_sync(&cmd->dataout_timer);
 
 	spin_lock_bh(&cmd->dataout_timeout_lock);
 	cmd->dataout_timer_flags &= ~ISCSI_TF_RUNNING;
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index ed2dadb..0bd62ab 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -922,7 +922,7 @@ void iscsit_stop_nopin_response_timer(struct iscsit_conn *conn)
 	conn->nopin_response_timer_flags |= ISCSI_TF_STOP;
 	spin_unlock_bh(&conn->nopin_timer_lock);
 
-	del_timer_sync(&conn->nopin_response_timer);
+	timer_delete_sync(&conn->nopin_response_timer);
 
 	spin_lock_bh(&conn->nopin_timer_lock);
 	conn->nopin_response_timer_flags &= ~ISCSI_TF_RUNNING;
@@ -989,7 +989,7 @@ void iscsit_stop_nopin_timer(struct iscsit_conn *conn)
 	conn->nopin_timer_flags |= ISCSI_TF_STOP;
 	spin_unlock_bh(&conn->nopin_timer_lock);
 
-	del_timer_sync(&conn->nopin_timer);
+	timer_delete_sync(&conn->nopin_timer);
 
 	spin_lock_bh(&conn->nopin_timer_lock);
 	conn->nopin_timer_flags &= ~ISCSI_TF_RUNNING;
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 0f5d820..43872cc 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1232,7 +1232,7 @@ static void tcmu_set_next_deadline(struct list_head *queue,
 		cmd = list_first_entry(queue, struct tcmu_cmd, queue_entry);
 		mod_timer(timer, cmd->deadline);
 	} else
-		del_timer(timer);
+		timer_delete(timer);
 }
 
 static int
@@ -2321,8 +2321,8 @@ static void tcmu_destroy_device(struct se_device *dev)
 {
 	struct tcmu_dev *udev = TCMU_DEV(dev);
 
-	del_timer_sync(&udev->cmd_timer);
-	del_timer_sync(&udev->qfull_timer);
+	timer_delete_sync(&udev->cmd_timer);
+	timer_delete_sync(&udev->qfull_timer);
 
 	mutex_lock(&root_udev_mutex);
 	list_del(&udev->node);
@@ -2408,7 +2408,7 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 	tcmu_flush_dcache_range(mb, sizeof(*mb));
 	clear_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
 
-	del_timer(&udev->cmd_timer);
+	timer_delete(&udev->cmd_timer);
 
 	/*
 	 * ring is empty and qfull queue never contains aborted commands.
diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index 001ec31..c13f523 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1496,7 +1496,7 @@ exit_nomem:
 static void handle_setup_get_version_rsp(struct ipw_hardware *hw,
 		unsigned char vers_no)
 {
-	del_timer(&hw->setup_timer);
+	timer_delete(&hw->setup_timer);
 	hw->initializing = 0;
 	printk(KERN_INFO IPWIRELESS_PCCARD_NAME ": card is ready.\n");
 
@@ -1721,7 +1721,7 @@ void ipwireless_stop_interrupts(struct ipw_hardware *hw)
 	if (!hw->shutting_down) {
 		/* Tell everyone we are going down. */
 		hw->shutting_down = 1;
-		del_timer(&hw->setup_timer);
+		timer_delete(&hw->setup_timer);
 
 		/* Prevent the hardware from sending any more interrupts */
 		do_close_hardware(hw);
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 58b28be..fa47bfc 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1031,7 +1031,7 @@ err_stop_irq:
 		raw_spin_unlock_irq(&priv->lock);
 	} else {
 		priv->removing = true;
-		del_timer_sync(&priv->poll_timer);
+		timer_delete_sync(&priv->poll_timer);
 	}
 	kthread_stop(priv->thread);
 err_destroy_ports:
@@ -1061,7 +1061,7 @@ static int mips_ejtag_fdc_tty_cpu_down(struct mips_cdmm_device *dev)
 		raw_spin_unlock_irq(&priv->lock);
 	} else {
 		priv->removing = true;
-		del_timer_sync(&priv->poll_timer);
+		timer_delete_sync(&priv->poll_timer);
 	}
 	kthread_stop(priv->thread);
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 1348e22..329b30f 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1187,7 +1187,7 @@ static void __exit moxa_exit(void)
 {
 	pci_unregister_driver(&moxa_pci_driver);
 
-	del_timer_sync(&moxaTimer);
+	timer_delete_sync(&moxaTimer);
 
 	tty_unregister_driver(moxaDriver);
 	tty_driver_kref_put(moxaDriver);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 363afe1..40a336e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1941,7 +1941,7 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
 		/* Our command was replied to, kill the retry timer */
-		del_timer(&gsm->t2_timer);
+		timer_delete(&gsm->t2_timer);
 		gsm->pending_cmd = NULL;
 		/* Rejected by the other end */
 		if (command == CMD_NSC)
@@ -2131,7 +2131,7 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
-	del_timer(&dlci->t1);
+	timer_delete(&dlci->t1);
 	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes closed.\n", dlci->addr);
 	dlci->state = DLCI_CLOSED;
@@ -2144,7 +2144,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 		tty_port_set_initialized(&dlci->port, false);
 		wake_up_interruptible(&dlci->port.open_wait);
 	} else {
-		del_timer(&dlci->gsm->ka_timer);
+		timer_delete(&dlci->gsm->ka_timer);
 		dlci->gsm->dead = true;
 	}
 	/* A DLCI 0 close is a MUX termination so we need to kick that
@@ -2166,7 +2166,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
 	   open -> open */
-	del_timer(&dlci->t1);
+	timer_delete(&dlci->t1);
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
 	dlci->constipated = false;
@@ -3144,9 +3144,9 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	}
 
 	/* Finish outstanding timers, making sure they are done */
-	del_timer_sync(&gsm->kick_timer);
-	del_timer_sync(&gsm->t2_timer);
-	del_timer_sync(&gsm->ka_timer);
+	timer_delete_sync(&gsm->kick_timer);
+	timer_delete_sync(&gsm->t2_timer);
+	timer_delete_sync(&gsm->ka_timer);
 
 	/* Finish writing to ldisc */
 	flush_work(&gsm->tx_work);
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index e5da9ce..3924470 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -550,7 +550,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 {
 	struct aspeed_vuart *vuart = platform_get_drvdata(pdev);
 
-	del_timer_sync(&vuart->unthrottle_timer);
+	timer_delete_sync(&vuart->unthrottle_timer);
 	aspeed_vuart_set_enabled(vuart, false);
 	serial8250_unregister_port(vuart->line);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 6f676bb..5a56f85 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -298,7 +298,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 
-	del_timer_sync(&up->timer);
+	timer_delete_sync(&up->timer);
 	up->timer.function = serial8250_timeout;
 	if (port->irq)
 		serial_unlink_irq_chain(up);
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 1759137..011f386 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -339,7 +339,7 @@ static void altera_uart_shutdown(struct uart_port *port)
 	if (port->irq)
 		free_irq(port->irq, port);
 	else
-		del_timer_sync(&pp->tmr);
+		timer_delete_sync(&pp->tmr);
 }
 
 static const char *altera_uart_type(struct uart_port *port)
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index dc09220..11d6509 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1084,7 +1084,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 
 		uap->dmarx.running = false;
 		dmaengine_terminate_all(rxchan);
-		del_timer(&uap->dmarx.timer);
+		timer_delete(&uap->dmarx.timer);
 	} else {
 		mod_timer(&uap->dmarx.timer,
 			  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
@@ -1199,7 +1199,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
 		if (uap->dmarx.poll_rate)
-			del_timer_sync(&uap->dmarx.timer);
+			timer_delete_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
 	}
 }
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8918fbd..18dba50 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2017,7 +2017,7 @@ static void atmel_shutdown(struct uart_port *port)
 	 * Prevent any tasklets being scheduled during
 	 * cleanup
 	 */
-	del_timer_sync(&atmel_port->uart_timer);
+	timer_delete_sync(&atmel_port->uart_timer);
 
 	/* Make sure that no interrupt is on the fly */
 	synchronize_irq(port->irq);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4470966..fe5aed9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1433,7 +1433,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 
 	dmaengine_terminate_sync(chan);
 	if (!sport->dma_idle_int)
-		del_timer_sync(&sport->lpuart_timer);
+		timer_delete_sync(&sport->lpuart_timer);
 
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
@@ -2071,7 +2071,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * baud rate and restart Rx DMA path.
 	 *
 	 * Since timer function acqures port->lock, need to stop before
-	 * acquring same lock because otherwise del_timer_sync() can deadlock.
+	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(port);
@@ -2316,7 +2316,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * baud rate and restart Rx DMA path.
 	 *
 	 * Since timer function acqures port->lock, need to stop before
-	 * acquring same lock because otherwise del_timer_sync() can deadlock.
+	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(port);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 19c8197..e4b6f1b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1619,7 +1619,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	/*
 	 * Stop our timer.
 	 */
-	del_timer_sync(&sport->timer);
+	timer_delete_sync(&sport->timer);
 
 	/*
 	 * Disable all interrupts, port and break condition.
@@ -1752,7 +1752,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		old_csize = CS8;
 	}
 
-	del_timer_sync(&sport->timer);
+	timer_delete_sync(&sport->timer);
 
 	/*
 	 * Ask the core to calculate the divisor for us.
diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 6c13cf1..3a0960c 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -96,7 +96,7 @@ static void liteuart_stop_rx(struct uart_port *port)
 	struct liteuart_port *uart = to_liteuart_port(port);
 
 	/* just delete timer */
-	del_timer(&uart->timer);
+	timer_delete(&uart->timer);
 }
 
 static void liteuart_rx_chars(struct uart_port *port)
@@ -220,7 +220,7 @@ static void liteuart_shutdown(struct uart_port *port)
 	if (port->irq)
 		free_irq(port->irq, port);
 	else
-		del_timer_sync(&uart->timer);
+		timer_delete_sync(&uart->timer);
 }
 
 static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index cde5f1c..f2dd836 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -506,7 +506,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 			MAX3100_STATUS_PE | MAX3100_STATUS_FE |
 			MAX3100_STATUS_OE;
 
-	del_timer_sync(&s->timer);
+	timer_delete_sync(&s->timer);
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	spin_lock(&s->conf_lock);
@@ -532,7 +532,7 @@ static void max3100_shutdown(struct uart_port *port)
 
 	s->force_end_work = 1;
 
-	del_timer_sync(&s->timer);
+	timer_delete_sync(&s->timer);
 
 	if (s->workqueue) {
 		destroy_workqueue(s->workqueue);
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 85ce1e9..b417fae 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -563,7 +563,7 @@ static void __exit mux_exit(void)
 {
 	/* Delete the Mux timer. */
 	if(port_cnt > 0) {
-		del_timer_sync(&mux_timer);
+		timer_delete_sync(&mux_timer);
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
 		unregister_console(&mux_console);
 #endif
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 3c34027..8587ebb 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -369,7 +369,7 @@ static void sa1100_shutdown(struct uart_port *port)
 	/*
 	 * Stop our timer.
 	 */
-	del_timer_sync(&sport->timer);
+	timer_delete_sync(&sport->timer);
 
 	/*
 	 * Free the interrupt
@@ -421,7 +421,7 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
 	quot = uart_get_divisor(port, baud);
 
-	del_timer_sync(&sport->timer);
+	timer_delete_sync(&sport->timer);
 
 	uart_port_lock_irqsave(&sport->port, &flags);
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 4c851da..553e3c1 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -1033,7 +1033,7 @@ static void sccnxp_remove(struct platform_device *pdev)
 	if (!s->poll)
 		devm_free_irq(&pdev->dev, s->irq, s);
 	else
-		del_timer_sync(&s->timer);
+		timer_delete_sync(&s->timer);
 
 	for (i = 0; i < s->uart.nr; i++)
 		uart_remove_one_port(&s->uart, &s->port[i]);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1c8480d..7e7813c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2337,7 +2337,7 @@ static void sci_shutdown(struct uart_port *port)
 #endif
 
 	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
-		del_timer_sync(&s->rx_fifo_timer);
+		timer_delete_sync(&s->rx_fifo_timer);
 	sci_free_irq(s);
 	sci_free_dma(port);
 }
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index bd8d92e..4c703f4 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2220,7 +2220,7 @@ static void isr_txeom(struct slgt_info *info, unsigned short status)
 		}
 		info->tx_active = false;
 
-		del_timer(&info->tx_timer);
+		timer_delete(&info->tx_timer);
 
 		if (info->params.mode != MGSL_MODE_ASYNC && info->drop_rts_on_tx_done) {
 			info->signals &= ~SerialSignal_RTS;
@@ -2375,8 +2375,8 @@ static void shutdown(struct slgt_info *info)
 	wake_up_interruptible(&info->status_event_wait_q);
 	wake_up_interruptible(&info->event_wait_q);
 
-	del_timer_sync(&info->tx_timer);
-	del_timer_sync(&info->rx_timer);
+	timer_delete_sync(&info->tx_timer);
+	timer_delete_sync(&info->rx_timer);
 
 	kfree(info->tx_buf);
 	info->tx_buf = NULL;
@@ -3955,7 +3955,7 @@ static void tx_stop(struct slgt_info *info)
 {
 	unsigned short val;
 
-	del_timer(&info->tx_timer);
+	timer_delete(&info->tx_timer);
 
 	tdma_reset(info);
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f85ce02..6853c46 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -743,7 +743,7 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 		 */
 		if (value && state->reset_seq_cnt) {
 			state->reset_canceled = true;
-			del_timer(&state->keyreset_timer);
+			timer_delete(&state->keyreset_timer);
 		}
 	} else if (value == 0) {
 		/*
@@ -751,7 +751,7 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 		 * to be pressed and held for the reset timeout
 		 * to hold.
 		 */
-		del_timer(&state->keyreset_timer);
+		timer_delete(&state->keyreset_timer);
 
 		if (--state->reset_seq_cnt == 0)
 			state->reset_canceled = false;
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 5b625f2..7ac3048 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -683,8 +683,8 @@ static void vcc_remove(struct vio_dev *vdev)
 {
 	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
 
-	del_timer_sync(&port->rx_timer);
-	del_timer_sync(&port->tx_timer);
+	timer_delete_sync(&port->rx_timer);
+	timer_delete_sync(&port->tx_timer);
 
 	/* If there's a process with the device open, do a synchronous
 	 * hangup of the TTY. This *may* cause the process to call close
@@ -700,7 +700,7 @@ static void vcc_remove(struct vio_dev *vdev)
 
 	tty_unregister_device(vcc_tty_driver, port->index);
 
-	del_timer_sync(&port->vio.timer);
+	timer_delete_sync(&port->vio.timer);
 	vio_ldc_free(&port->vio);
 	sysfs_remove_group(&vdev->dev.kobj, &vcc_attribute_group);
 	dev_set_drvdata(&vdev->dev, NULL);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 804355d..ae92e6a 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -275,7 +275,7 @@ static DEFINE_TIMER(kd_mksound_timer, kd_nosound);
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
-	del_timer_sync(&kd_mksound_timer);
+	timer_delete_sync(&kd_mksound_timer);
 
 	input_handler_for_each_handle(&kbd_handler, &hz, kd_sound_helper);
 
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index be5564e..f5642b3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4501,7 +4501,7 @@ void do_blank_screen(int entering_gfx)
 	}
 
 	hide_cursor(vc);
-	del_timer_sync(&console_timer);
+	timer_delete_sync(&console_timer);
 	blank_timer_expired = 0;
 
 	save_screen(vc);
@@ -4606,7 +4606,7 @@ void poke_blanked_console(void)
 	/* This isn't perfectly race free, but a race here would be mostly harmless,
 	 * at worst, we'll do a spurious blank and it's unlikely
 	 */
-	del_timer(&console_timer);
+	timer_delete(&console_timer);
 	blank_timer_expired = 0;
 
 	if (ignore_poke || !vc_cons[fg_console].d || vc_cons[fg_console].d->vc_mode == KD_GRAPHICS)
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 47d06af..c6b9ad1 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -597,7 +597,7 @@ static int cxacru_start_wait_urb(struct urb *urb, struct completion *done,
 	timer_setup_on_stack(&timer.timer, cxacru_timeout_kill, 0);
 	mod_timer(&timer.timer, jiffies + msecs_to_jiffies(CMD_TIMEOUT));
 	wait_for_completion(done);
-	del_timer_sync(&timer.timer);
+	timer_delete_sync(&timer.timer);
 	destroy_timer_on_stack(&timer.timer);
 
 	if (actual_length)
diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
index 973548b..27e3d35 100644
--- a/drivers/usb/atm/speedtch.c
+++ b/drivers/usb/atm/speedtch.c
@@ -612,7 +612,7 @@ static void speedtch_handle_int(struct urb *int_urb)
 	}
 
 	if ((count == 6) && !memcmp(up_int, instance->int_data, 6)) {
-		del_timer(&instance->status_check_timer);
+		timer_delete(&instance->status_check_timer);
 		atm_info(usbatm, "DSL line goes up\n");
 	} else if ((count == 6) && !memcmp(down_int, instance->int_data, 6)) {
 		atm_info(usbatm, "DSL line goes down\n");
@@ -688,7 +688,7 @@ static void speedtch_atm_stop(struct usbatm_data *usbatm, struct atm_dev *atm_de
 
 	atm_dbg(usbatm, "%s entered\n", __func__);
 
-	del_timer_sync(&instance->status_check_timer);
+	timer_delete_sync(&instance->status_check_timer);
 
 	/*
 	 * Since resubmit_timer and int_urb can schedule themselves and
@@ -697,14 +697,14 @@ static void speedtch_atm_stop(struct usbatm_data *usbatm, struct atm_dev *atm_de
 	instance->int_urb = NULL; /* signal shutdown */
 	mb();
 	usb_kill_urb(int_urb);
-	del_timer_sync(&instance->resubmit_timer);
+	timer_delete_sync(&instance->resubmit_timer);
 	/*
 	 * At this point, speedtch_handle_int and speedtch_resubmit_int
 	 * can run or be running, but instance->int_urb == NULL means that
 	 * they will not reschedule
 	 */
 	usb_kill_urb(int_urb);
-	del_timer_sync(&instance->resubmit_timer);
+	timer_delete_sync(&instance->resubmit_timer);
 	usb_free_urb(int_urb);
 
 	flush_work(&instance->status_check_work);
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index d1e622b..a6a05e8 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1237,8 +1237,8 @@ void usbatm_usb_disconnect(struct usb_interface *intf)
 	for (i = 0; i < num_rcv_urbs + num_snd_urbs; i++)
 		usb_kill_urb(instance->urbs[i]);
 
-	del_timer_sync(&instance->rx_channel.delay);
-	del_timer_sync(&instance->tx_channel.delay);
+	timer_delete_sync(&instance->rx_channel.delay);
+	timer_delete_sync(&instance->tx_channel.delay);
 
 	/* turn usbatm_[rt]x_process into something close to a no-op */
 	/* no need to take the spinlock */
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 46026b3..a63c793 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -842,7 +842,7 @@ static int usb_rh_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	} else {				/* Status URB */
 		if (!hcd->uses_new_polling)
-			del_timer (&hcd->rh_timer);
+			timer_delete(&hcd->rh_timer);
 		if (urb == hcd->status_urb) {
 			hcd->status_urb = NULL;
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
@@ -2768,14 +2768,14 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
 {
 	hcd->rh_pollable = 0;
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 
 	hcd->driver->stop(hcd);
 	hcd->state = HC_STATE_HALT;
 
 	/* In case the HCD restarted the timer, stop it again. */
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 }
 
 /**
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8c7f9cc..0e1dd6e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1385,7 +1385,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 	}
 
 	/* Stop hub_wq and related activity */
-	del_timer_sync(&hub->irq_urb_retry);
+	timer_delete_sync(&hub->irq_urb_retry);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 8692452..60ef809 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5081,7 +5081,7 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 
 	cancel_work_sync(&hsotg->phy_reset_work);
 
-	del_timer(&hsotg->wkp_timer);
+	timer_delete(&hsotg->wkp_timer);
 }
 
 static void dwc2_hcd_release(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 2a542a9..b009879 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1302,7 +1302,7 @@ static int dwc2_schedule_periodic(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	}
 
 	/* Cancel pending unreserve; if canceled OK, unreserve was pending */
-	if (del_timer(&qh->unreserve_timer))
+	if (timer_delete(&qh->unreserve_timer))
 		WARN_ON(!qh->unreserve_pending);
 
 	/*
@@ -1614,7 +1614,7 @@ struct dwc2_qh *dwc2_hcd_qh_create(struct dwc2_hsotg *hsotg,
 void dwc2_hcd_qh_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 {
 	/* Make sure any unreserve work is finished. */
-	if (del_timer_sync(&qh->unreserve_timer)) {
+	if (timer_delete_sync(&qh->unreserve_timer)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&hsotg->lock, flags);
diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index e25e0d8..a05785b 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -194,7 +194,7 @@ static void zero_suspend(struct usb_composite_dev *cdev)
 static void zero_resume(struct usb_composite_dev *cdev)
 {
 	DBG(cdev, "%s\n", __func__);
-	del_timer(&autoresume_timer);
+	timer_delete(&autoresume_timer);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -398,7 +398,7 @@ err_put_func_inst_ss:
 
 static int zero_unbind(struct usb_composite_dev *cdev)
 {
-	del_timer_sync(&autoresume_timer);
+	timer_delete_sync(&autoresume_timer);
 	if (!IS_ERR_OR_NULL(func_ss))
 		usb_put_function(func_ss);
 	usb_put_function_instance(func_inst_ss);
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 8902abe..c93ea21 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -252,7 +252,7 @@ static int omap_ep_disable(struct usb_ep *_ep)
 	ep->has_dma = 0;
 	omap_writew(UDC_SET_HALT, UDC_CTRL);
 	list_del_init(&ep->iso);
-	del_timer(&ep->timer);
+	timer_delete(&ep->timer);
 
 	spin_unlock_irqrestore(&ep->udc->lock, flags);
 
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 1e99980..24eb1ae 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1503,7 +1503,7 @@ reset_gadget(struct pxa25x_udc *dev, struct usb_gadget_driver *driver)
 		ep->stopped = 1;
 		nuke(ep, -ESHUTDOWN);
 	}
-	del_timer_sync(&dev->timer);
+	timer_delete_sync(&dev->timer);
 
 	/* report reset; the driver is already quiesced */
 	if (driver)
@@ -1530,7 +1530,7 @@ stop_activity(struct pxa25x_udc *dev, struct usb_gadget_driver *driver)
 		ep->stopped = 1;
 		nuke(ep, -ESHUTDOWN);
 	}
-	del_timer_sync(&dev->timer);
+	timer_delete_sync(&dev->timer);
 
 	/* report disconnect; the driver is already quiesced */
 	if (driver)
@@ -1607,14 +1607,14 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 	if (udccs0 & UDCCS0_SST) {
 		nuke(ep, -EPIPE);
 		udc_ep0_set_UDCCS(dev, UDCCS0_SST);
-		del_timer(&dev->timer);
+		timer_delete(&dev->timer);
 		ep0_idle(dev);
 	}
 
 	/* previous request unfinished?  non-error iff back-to-back ... */
 	if ((udccs0 & UDCCS0_SA) != 0 && dev->ep0state != EP0_IDLE) {
 		nuke(ep, 0);
-		del_timer(&dev->timer);
+		timer_delete(&dev->timer);
 		ep0_idle(dev);
 	}
 
diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index ff6f846..6c1d15b 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1810,7 +1810,7 @@ static void r8a66597_remove(struct platform_device *pdev)
 	struct r8a66597		*r8a66597 = platform_get_drvdata(pdev);
 
 	usb_del_gadget_udc(&r8a66597->gadget);
-	del_timer_sync(&r8a66597->timer);
+	timer_delete_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
 	if (r8a66597->pdata->on_chip) {
diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 1f8a99d..373942c 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -3035,12 +3035,12 @@ void udc_remove(struct udc *dev)
 	stop_timer++;
 	if (timer_pending(&udc_timer))
 		wait_for_completion(&on_exit);
-	del_timer_sync(&udc_timer);
+	timer_delete_sync(&udc_timer);
 	/* remove pollstall timer */
 	stop_pollstall_timer++;
 	if (timer_pending(&udc_pollstall_timer))
 		wait_for_completion(&on_pollstall_exit);
-	del_timer_sync(&udc_pollstall_timer);
+	timer_delete_sync(&udc_pollstall_timer);
 	udc = NULL;
 }
 EXPORT_SYMBOL_GPL(udc_remove);
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index cdf4188..150d254 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -224,7 +224,7 @@ static void quirk_poll_init(struct ehci_platform_priv *priv)
 
 static void quirk_poll_end(struct ehci_platform_priv *priv)
 {
-	del_timer_sync(&priv->poll_timer);
+	timer_delete_sync(&priv->poll_timer);
 	cancel_delayed_work(&priv->poll_work);
 }
 
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 2d3a082..954fc5a 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2357,7 +2357,7 @@ static void isp1362_hc_stop(struct usb_hcd *hcd)
 
 	pr_debug("%s:\n", __func__);
 
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 
 	spin_lock_irqsave(&isp1362_hcd->lock, flags);
 
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9b24181..c7784bf 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1003,7 +1003,7 @@ static void ohci_stop (struct usb_hcd *hcd)
 
 	if (quirk_nec(ohci))
 		flush_work(&ohci->nec_work);
-	del_timer_sync(&ohci->io_watchdog);
+	timer_delete_sync(&ohci->io_watchdog);
 	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 90cee19..b3d734a 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -315,7 +315,7 @@ static int ohci_bus_suspend (struct usb_hcd *hcd)
 	spin_unlock_irq (&ohci->lock);
 
 	if (rc == 0) {
-		del_timer_sync(&ohci->io_watchdog);
+		timer_delete_sync(&ohci->io_watchdog);
 		ohci->prev_frame_no = IO_WATCHDOG_OFF;
 	}
 	return rc;
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index fce800b..d75b1b9 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -1127,7 +1127,7 @@ static void ehci_mem_cleanup(struct oxu_hcd *oxu)
 		qh_put(oxu->async);
 	oxu->async = NULL;
 
-	del_timer(&oxu->urb_timer);
+	timer_delete(&oxu->urb_timer);
 
 	oxu->periodic = NULL;
 
@@ -3154,7 +3154,7 @@ static void oxu_stop(struct usb_hcd *hcd)
 	ehci_port_power(oxu, 0);
 
 	/* no more interrupts ... */
-	del_timer_sync(&oxu->watchdog);
+	timer_delete_sync(&oxu->watchdog);
 
 	spin_lock_irq(&oxu->lock);
 	if (HC_IS_RUNNING(hcd->state))
@@ -3887,7 +3887,7 @@ static int oxu_bus_suspend(struct usb_hcd *hcd)
 
 	spin_unlock_irq(&oxu->lock);
 	/* turn off now-idle HC */
-	del_timer_sync(&oxu->watchdog);
+	timer_delete_sync(&oxu->watchdog);
 	spin_lock_irq(&oxu->lock);
 	ehci_halt(oxu);
 	hcd->state = HC_STATE_SUSPENDED;
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index a44992e..67e4721 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2384,7 +2384,7 @@ static void r8a66597_remove(struct platform_device *pdev)
 	struct r8a66597		*r8a66597 = platform_get_drvdata(pdev);
 	struct usb_hcd		*hcd = r8a66597_to_hcd(r8a66597);
 
-	del_timer_sync(&r8a66597->rh_timer);
+	timer_delete_sync(&r8a66597->rh_timer);
 	usb_remove_hcd(hcd);
 	iounmap(r8a66597->reg);
 	if (r8a66597->pdata->on_chip)
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index fa2e4ba..718b1b7 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1515,7 +1515,7 @@ sl811h_stop(struct usb_hcd *hcd)
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	unsigned long	flags;
 
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 
 	spin_lock_irqsave(&sl811->lock, flags);
 	port_power(sl811, 0);
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index fd2408b..14e6dfe 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -716,7 +716,7 @@ static void uhci_stop(struct usb_hcd *hcd)
 	spin_unlock_irq(&uhci->lock);
 	synchronize_irq(hcd->irq);
 
-	del_timer_sync(&uhci->fsbr_timer);
+	timer_delete_sync(&uhci->fsbr_timer);
 	release_uhci(uhci);
 }
 
diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
index 35fcb82..45a8256 100644
--- a/drivers/usb/host/uhci-q.c
+++ b/drivers/usb/host/uhci-q.c
@@ -84,7 +84,7 @@ static void uhci_urbp_wants_fsbr(struct uhci_hcd *uhci, struct urb_priv *urbp)
 			uhci_fsbr_on(uhci);
 		else if (uhci->fsbr_expiring) {
 			uhci->fsbr_expiring = 0;
-			del_timer(&uhci->fsbr_timer);
+			timer_delete(&uhci->fsbr_timer);
 		}
 	}
 }
diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 46fdab9..05943f2 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -327,7 +327,7 @@ static int xenhcd_bus_suspend(struct usb_hcd *hcd)
 	}
 	spin_unlock_irq(&info->lock);
 
-	del_timer_sync(&info->watchdog);
+	timer_delete_sync(&info->watchdog);
 
 	return ret;
 }
@@ -1307,7 +1307,7 @@ static void xenhcd_stop(struct usb_hcd *hcd)
 {
 	struct xenhcd_info *info = xenhcd_hcd_to_info(hcd);
 
-	del_timer_sync(&info->watchdog);
+	timer_delete_sync(&info->watchdog);
 	spin_lock_irq(&info->lock);
 	/* cancel all urbs */
 	hcd->state = HC_STATE_HALT;
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 69c278b..c0f2265 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -926,7 +926,7 @@ static void xhci_del_comp_mod_timer(struct xhci_hcd *xhci, u32 status,
 	if ((xhci->port_status_u0 != all_ports_seen_u0) && port_in_u0) {
 		xhci->port_status_u0 |= 1 << wIndex;
 		if (xhci->port_status_u0 == all_ports_seen_u0) {
-			del_timer_sync(&xhci->comp_mode_recovery_timer);
+			timer_delete_sync(&xhci->comp_mode_recovery_timer);
 			xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"All USB3 ports have entered U0 already!");
 			xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 9048313..208558c 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -746,10 +746,10 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 
 	xhci_dbg(xhci, "%s: stop port polling\n", __func__);
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 	if (shared_hcd) {
 		clear_bit(HCD_FLAG_POLL_RH, &shared_hcd->flags);
-		del_timer_sync(&shared_hcd->rh_timer);
+		timer_delete_sync(&shared_hcd->rh_timer);
 	}
 
 	ret = xhci_mtk_host_disable(mtk);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 83a4adf..2d7149c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -627,7 +627,7 @@ void xhci_stop(struct usb_hcd *hcd)
 	/* Deleting Compliance Mode Recovery Timer */
 	if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 			(!(xhci_all_ports_seen_u0(xhci)))) {
-		del_timer_sync(&xhci->comp_mode_recovery_timer);
+		timer_delete_sync(&xhci->comp_mode_recovery_timer);
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"%s: compliance mode recovery timer deleted",
 				__func__);
@@ -672,11 +672,11 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	xhci_dbg(xhci, "%s: stopping usb%d port polling.\n",
 			__func__, hcd->self.busnum);
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 
 	if (xhci->shared_hcd) {
 		clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-		del_timer_sync(&xhci->shared_hcd->rh_timer);
+		timer_delete_sync(&xhci->shared_hcd->rh_timer);
 	}
 
 	spin_lock_irq(&xhci->lock);
@@ -908,10 +908,10 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	xhci_dbg(xhci, "%s: stopping usb%d port polling.\n",
 		 __func__, hcd->self.busnum);
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	timer_delete_sync(&hcd->rh_timer);
 	if (xhci->shared_hcd) {
 		clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
-		del_timer_sync(&xhci->shared_hcd->rh_timer);
+		timer_delete_sync(&xhci->shared_hcd->rh_timer);
 	}
 
 	if (xhci->quirks & XHCI_SUSPEND_DELAY)
@@ -978,7 +978,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	 */
 	if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 			(!(xhci_all_ports_seen_u0(xhci)))) {
-		del_timer_sync(&xhci->comp_mode_recovery_timer);
+		timer_delete_sync(&xhci->comp_mode_recovery_timer);
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"%s: compliance mode recovery timer deleted",
 				__func__);
@@ -1071,7 +1071,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
 	if (power_lost) {
 		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 				!(xhci_all_ports_seen_u0(xhci))) {
-			del_timer_sync(&xhci->comp_mode_recovery_timer);
+			timer_delelet_sync(&xhci->comp_mode_recovery_timer);
 			xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"Compliance Mode Recovery Timer deleted!");
 		}
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index add2d2e..8dcd9cc 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -2458,7 +2458,7 @@ static void isp1760_stop(struct usb_hcd *hcd)
 {
 	struct isp1760_hcd *priv = hcd_to_priv(hcd);
 
-	del_timer(&errata2_timer);
+	timer_delete(&errata2_timer);
 
 	isp1760_hub_control(hcd, ClearPortFeature, USB_PORT_FEAT_POWER,	1,
 			NULL, 0);
diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index 5cafd23..2af89ee 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1145,7 +1145,7 @@ static void isp1760_udc_disconnect(struct isp1760_udc *udc)
 	if (udc->driver->disconnect)
 		udc->driver->disconnect(&udc->gadget);
 
-	del_timer(&udc->vbus_timer);
+	timer_delete(&udc->vbus_timer);
 
 	/* TODO Reset all endpoints ? */
 }
@@ -1314,7 +1314,7 @@ static int isp1760_udc_stop(struct usb_gadget *gadget)
 
 	dev_dbg(udc->isp->dev, "%s\n", __func__);
 
-	del_timer_sync(&udc->vbus_timer);
+	timer_delete_sync(&udc->vbus_timer);
 
 	isp1760_reg_write(udc->regs, mode_reg, 0);
 
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 8d379ae..853a5f0 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -626,7 +626,7 @@ static int perform_sglist(
 		mod_timer(&timeout.timer, jiffies +
 				msecs_to_jiffies(SIMPLE_IO_TIMEOUT));
 		usb_sg_wait(req);
-		if (!del_timer_sync(&timeout.timer))
+		if (!timer_delete_sync(&timeout.timer))
 			retval = -ETIMEDOUT;
 		else
 			retval = req->status;
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 26fd71a..eebb24a 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -204,7 +204,7 @@ static void __maybe_unused da8xx_musb_try_idle(struct musb *musb, unsigned long 
 				musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
 			usb_otg_state_string(musb->xceiv->otg->state));
-		del_timer(&musb->dev_timer);
+		timer_delete(&musb->dev_timer);
 		last_timer = jiffies;
 		return;
 	}
@@ -290,7 +290,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
 			portstate(musb->port1_status |= USB_PORT_STAT_POWER);
-			del_timer(&musb->dev_timer);
+			timer_delete(&musb->dev_timer);
 		} else if (!(musb->int_usb & MUSB_INTR_BABBLE)) {
 			/*
 			 * When babble condition happens, drvvbus interrupt
@@ -419,7 +419,7 @@ static int da8xx_musb_exit(struct musb *musb)
 {
 	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
 
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 
 	phy_power_off(glue->phy);
 	phy_exit(glue->phy);
diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index 71e4271..020348a 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -165,7 +165,7 @@ static void __maybe_unused mpfs_musb_try_idle(struct musb *musb, unsigned long t
 				musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
 			usb_otg_state_string(musb->xceiv->otg->state));
-		del_timer(&musb->dev_timer);
+		timer_delete(&musb->dev_timer);
 		last_timer = jiffies;
 		return;
 	}
@@ -232,7 +232,7 @@ static int mpfs_musb_init(struct musb *musb)
 
 static int mpfs_musb_exit(struct musb *musb)
 {
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 96fa700..cbbb271 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -921,7 +921,7 @@ b_host:
 		musb_set_state(musb, OTG_STATE_B_HOST);
 		if (musb->hcd)
 			musb->hcd->self.is_b_host = 1;
-		del_timer(&musb->otg_timer);
+		timer_delete(&musb->otg_timer);
 		break;
 	default:
 		if ((devctl & MUSB_DEVCTL_VBUS)
@@ -1015,7 +1015,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 				+ msecs_to_jiffies(TA_WAIT_BCON(musb)));
 			break;
 		case OTG_STATE_A_PERIPHERAL:
-			del_timer(&musb->otg_timer);
+			timer_delete(&musb->otg_timer);
 			musb_g_reset(musb);
 			break;
 		case OTG_STATE_B_WAIT_ACON:
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index f877faf..e5e813f 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -201,7 +201,7 @@ static void dsps_musb_disable(struct musb *musb)
 	musb_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
 	musb_writel(reg_base, wrp->epintr_clear,
 			 wrp->txep_bitmap | wrp->rxep_bitmap);
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 }
 
 /* Caller must take musb->lock */
@@ -215,7 +215,7 @@ static int dsps_check_status(struct musb *musb, void *unused)
 	int skip_session = 0;
 
 	if (glue->vbus_irq)
-		del_timer(&musb->dev_timer);
+		timer_delete(&musb->dev_timer);
 
 	/*
 	 * We poll because DSPS IP's won't expose several OTG-critical
@@ -499,7 +499,7 @@ static int dsps_musb_exit(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 	phy_power_off(musb->phy);
 	phy_exit(musb->phy);
 	debugfs_remove_recursive(glue->dbgfs_root);
@@ -983,7 +983,7 @@ static int dsps_suspend(struct device *dev)
 		return ret;
 	}
 
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 
 	mbase = musb->ctrl_base;
 	glue->context.control = musb_readl(mbase, wrp->control);
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 90b760a..abd2472 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -525,7 +525,7 @@ static void tusb_musb_try_idle(struct musb *musb, unsigned long timeout)
 			&& (musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON))) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
 			usb_otg_state_string(musb->xceiv->otg->state));
-		del_timer(&musb->dev_timer);
+		timer_delete(&musb->dev_timer);
 		last_timer = jiffies;
 		return;
 	}
@@ -875,7 +875,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 	}
 
 	if (int_src & TUSB_INT_SRC_USB_IP_CONN)
-		del_timer(&musb->dev_timer);
+		timer_delete(&musb->dev_timer);
 
 	/* OTG state change reports (annoyingly) not issued by Mentor core */
 	if (int_src & (TUSB_INT_SRC_VBUS_SENSE_CHNG
@@ -984,7 +984,7 @@ static void tusb_musb_disable(struct musb *musb)
 	musb_writel(tbase, TUSB_DMA_INT_MASK, 0x7fffffff);
 	musb_writel(tbase, TUSB_GPIO_INT_MASK, 0x1ff);
 
-	del_timer(&musb->dev_timer);
+	timer_delete(&musb->dev_timer);
 
 	if (is_dma_capable() && !dma_off) {
 		printk(KERN_WARNING "%s %s: dma still active\n",
@@ -1174,7 +1174,7 @@ static int tusb_musb_exit(struct musb *musb)
 {
 	struct tusb6010_glue *glue = dev_get_drvdata(musb->controller->parent);
 
-	del_timer_sync(&musb->dev_timer);
+	timer_delete_sync(&musb->dev_timer);
 	the_musb = NULL;
 
 	gpiod_set_value(glue->enable, 0);
diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index 30d6c88..638fba5 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -110,7 +110,7 @@ static int mv_otg_cancel_timer(struct mv_otg *mvotg, unsigned int id)
 	timer = &mvotg->otg_ctrl.timer[id];
 
 	if (timer_pending(timer))
-		del_timer(timer);
+		timer_delete(timer);
 
 	return 0;
 }
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 4e516b4..b387863 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -934,7 +934,7 @@ static void realtek_cr_destructor(void *extra)
 
 #ifdef CONFIG_REALTEK_AUTOPM
 	if (ss_en) {
-		del_timer(&chip->rts51x_suspend_timer);
+		timer_delete(&chip->rts51x_suspend_timer);
 		chip->timer_expires = 0;
 	}
 #endif
diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index 9e41d2a..bf764c9 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -59,7 +59,7 @@ static int radeon_bl_update_status(struct backlight_device *bd)
 	 */
 	level = backlight_get_brightness(bd);
 
-	del_timer_sync(&rinfo->lvds_timer);
+	timer_delete_sync(&rinfo->lvds_timer);
 	radeon_engine_idle();
 
 	lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index d866608..c6c4753 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1082,7 +1082,7 @@ int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch)
 		}
 		break;
 	case MT_LCD:
-		del_timer_sync(&rinfo->lvds_timer);
+		timer_delete_sync(&rinfo->lvds_timer);
 		val = INREG(LVDS_GEN_CNTL);
 		if (unblank) {
 			u32 target_val = (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
@@ -2516,7 +2516,7 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
 	if (rinfo->mon2_EDID)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
 
-	del_timer_sync(&rinfo->lvds_timer);
+	timer_delete_sync(&rinfo->lvds_timer);
 	arch_phys_wc_del(rinfo->wc_cookie);
         radeonfb_bl_exit(rinfo);
 	unregister_framebuffer(info);
diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index 97a5972..5ff4a96 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2650,7 +2650,7 @@ static int radeonfb_pci_suspend_late(struct device *dev, pm_message_t mesg)
 	/* Sleep */
 	rinfo->asleep = 1;
 	rinfo->lock_blank = 1;
-	del_timer_sync(&rinfo->lvds_timer);
+	timer_delete_sync(&rinfo->lvds_timer);
 
 #ifdef CONFIG_PPC_PMAC
 	/* On powermac, we have hooks to properly suspend/resume AGP now,
diff --git a/drivers/video/fbdev/omap/hwa742.c b/drivers/video/fbdev/omap/hwa742.c
index 161fc65..64e76e1 100644
--- a/drivers/video/fbdev/omap/hwa742.c
+++ b/drivers/video/fbdev/omap/hwa742.c
@@ -597,7 +597,7 @@ static int hwa742_set_update_mode(enum omapfb_update_mode mode)
 		break;
 	case OMAPFB_AUTO_UPDATE:
 		hwa742.stop_auto_update = 1;
-		del_timer_sync(&hwa742.auto_update_timer);
+		timer_delete_sync(&hwa742.auto_update_timer);
 		break;
 	case OMAPFB_UPDATE_DISABLED:
 		break;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 1f3434c..370e862 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -835,7 +835,7 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 
 #ifdef DSI_CATCH_MISSING_TE
 	if (irqstatus & DSI_IRQ_TE_TRIGGER)
-		del_timer(&dsi->te_timer);
+		timer_delete(&dsi->te_timer);
 #endif
 
 	/* make a copy and unlock, so that isrs can unregister
diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index c6e9855..f1674f3 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -495,7 +495,7 @@ static int vbg_heartbeat_init(struct vbg_dev *gdev)
  */
 static void vbg_heartbeat_exit(struct vbg_dev *gdev)
 {
-	del_timer_sync(&gdev->heartbeat_timer);
+	timer_delete_sync(&gdev->heartbeat_timer);
 	vbg_heartbeat_host_config(gdev, false);
 	vbg_req_free(gdev->guest_heartbeat_req,
 		     sizeof(*gdev->guest_heartbeat_req));
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 9c7cf93..03a559b 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -166,7 +166,7 @@ static void wdt_startup(void)
 static void wdt_turnoff(void)
 {
 	/* Stop the timer */
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 	wdt_change(WDT_DISABLE);
 	pr_info("Watchdog timer is now disabled...\n");
 }
@@ -223,7 +223,7 @@ static int fop_close(struct inode *inode, struct file *file)
 	if (wdt_expect_close == 42)
 		wdt_turnoff();
 	else {
-		/* wim: shouldn't there be a: del_timer(&timer); */
+		/* wim: shouldn't there be a: timer_delete(&timer); */
 		pr_crit("device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &wdt_is_open);
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 7be70b9..1b47a2f 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -242,7 +242,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	return 0;
 
 out_stop_timer:
-	del_timer(&wdt->timer);
+	timer_delete(&wdt->timer);
 	return err;
 }
 
@@ -378,7 +378,7 @@ static void at91wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
-	del_timer(&wdt->timer);
+	timer_delete(&wdt->timer);
 }
 
 #if defined(CONFIG_OF)
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 06a54c7..4c09513 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -139,7 +139,7 @@ static int bcm47xx_wdt_soft_stop(struct watchdog_device *wdd)
 {
 	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
-	del_timer_sync(&wdt->soft_timer);
+	timer_delete_sync(&wdt->soft_timer);
 	wdt->timer_set(wdt, 0);
 
 	return 0;
@@ -213,7 +213,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 
 err_timer:
 	if (soft)
-		del_timer_sync(&wdt->soft_timer);
+		timer_delete_sync(&wdt->soft_timer);
 
 	return ret;
 }
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 4fb92c9..13a4d47 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -240,7 +240,7 @@ static void cpwd_brokentimer(struct timer_list *unused)
 	 * were called directly instead of by kernel timer
 	 */
 	if (timer_pending(&cpwd_timer))
-		del_timer(&cpwd_timer);
+		timer_delete(&cpwd_timer);
 
 	for (id = 0; id < WD_NUMDEVS; id++) {
 		if (p->devs[id].runstatus & WD_STAT_BSTOP) {
@@ -629,7 +629,7 @@ static void cpwd_remove(struct platform_device *op)
 	}
 
 	if (p->broken)
-		del_timer_sync(&cpwd_timer);
+		timer_delete_sync(&cpwd_timer);
 
 	if (p->initialized)
 		free_irq(p->irq, p);
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index f19580e..28e3fc0 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -135,7 +135,7 @@ static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
 	unsigned int val;
 
 	if (timer_pending(&lpc18xx_wdt->timer))
-		del_timer(&lpc18xx_wdt->timer);
+		timer_delete(&lpc18xx_wdt->timer);
 
 	val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
 	val |= LPC18XX_WDT_MOD_WDEN;
@@ -266,7 +266,7 @@ static void lpc18xx_wdt_remove(struct platform_device *pdev)
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
 
 	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
-	del_timer_sync(&lpc18xx_wdt->timer);
+	timer_delete_sync(&lpc18xx_wdt->timer);
 }
 
 static const struct of_device_id lpc18xx_wdt_match[] = {
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 73d6414..0ae8e5b 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -189,7 +189,7 @@ static void zf_timer_off(void)
 	unsigned long flags;
 
 	/* stop internal ping */
-	del_timer_sync(&zf_timer);
+	timer_delete_sync(&zf_timer);
 
 	spin_lock_irqsave(&zf_port_lock, flags);
 	/* stop watchdog timer */
@@ -337,7 +337,7 @@ static int zf_close(struct inode *inode, struct file *file)
 	if (zf_expect_close == 42)
 		zf_timer_off();
 	else {
-		del_timer(&zf_timer);
+		timer_delete(&zf_timer);
 		pr_err("device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &zf_is_open);
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index 70d9cf8..1ecd5c4 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -141,7 +141,7 @@ static int mixcomwd_open(struct inode *inode, struct file *file)
 		__module_get(THIS_MODULE);
 	else {
 		if (mixcomwd_timer_alive) {
-			del_timer(&mixcomwd_timer);
+			timer_delete(&mixcomwd_timer);
 			mixcomwd_timer_alive = 0;
 		}
 	}
@@ -295,7 +295,7 @@ static void __exit mixcomwd_exit(void)
 	if (!nowayout) {
 		if (mixcomwd_timer_alive) {
 			pr_warn("I quit now, hardware will probably reboot!\n");
-			del_timer_sync(&mixcomwd_timer);
+			timer_delete_sync(&mixcomwd_timer);
 			mixcomwd_timer_alive = 0;
 		}
 	}
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index 31d3dcb..d4ea7d6 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -432,7 +432,7 @@ static int pcwd_stop(void)
 	int stat_reg;
 
 	/* Stop the timer */
-	del_timer(&pcwd_private.timer);
+	timer_delete(&pcwd_private.timer);
 
 	/*  Disable the board  */
 	if (pcwd_private.revision == PCWD_REVISION_C) {
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 393aa4b..87b8988 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -129,7 +129,7 @@ static int pikawdt_release(struct inode *inode, struct file *file)
 {
 	/* stop internal ping */
 	if (!pikawdt_private.expect_close)
-		del_timer(&pikawdt_private.timer);
+		timer_delete(&pikawdt_private.timer);
 
 	clear_bit(0, &pikawdt_private.open);
 	pikawdt_private.expect_close = 0;
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index e9bf129..03eaf48 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -146,7 +146,7 @@ static void wdt_startup(void)
 static void wdt_turnoff(void)
 {
 	/* Stop the timer */
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 	inb_p(wdt_stop);
 	pr_info("Watchdog timer is now disabled...\n");
 }
@@ -210,7 +210,7 @@ static int fop_close(struct inode *inode, struct file *file)
 	if (wdt_expect_close == 42)
 		wdt_turnoff();
 	else {
-		del_timer(&timer);
+		timer_delete(&timer);
 		pr_crit("device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &wdt_is_open);
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index e849e1a..005f62e 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -186,7 +186,7 @@ static int wdt_startup(void)
 static int wdt_turnoff(void)
 {
 	/* Stop the timer */
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 
 	/* Stop the watchdog */
 	wdt_config(0);
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 7f0150c..95af9ad 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -129,7 +129,7 @@ static int sh_wdt_stop(struct watchdog_device *wdt_dev)
 
 	spin_lock_irqsave(&wdt->lock, flags);
 
-	del_timer(&wdt->timer);
+	timer_delete(&wdt->timer);
 
 	csr = sh_wdt_read_csr();
 	csr &= ~WTCSR_TME;
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index eeb39f9..d647923 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -233,7 +233,7 @@ err_out_disable_device:
 static void wdt_remove(struct pci_dev *pdev)
 {
 	watchdog_unregister_device(&wdt_dev);
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 	iounmap(wdt_mem);
 	release_mem_region(mmio, VIA_WDT_MMIO_LEN);
 	release_resource(&wdt_res);
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index 1937084..53db59e 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -166,7 +166,7 @@ static void wdt_startup(void)
 static void wdt_turnoff(void)
 {
 	/* Stop the timer */
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 
 	wdt_change(WDT_DISABLE);
 
@@ -228,7 +228,7 @@ static int fop_close(struct inode *inode, struct file *file)
 	if (wdt_expect_close == 42)
 		wdt_turnoff();
 	else {
-		del_timer(&timer);
+		timer_delete(&timer);
 		pr_crit("device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &wdt_is_open);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 07a8bfb..e0030ac 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -534,6 +534,6 @@ dont_wait:
  */
 void afs_fs_probe_cleanup(struct afs_net *net)
 {
-	if (del_timer_sync(&net->fs_probe_timer))
+	if (timer_delete_sync(&net->fs_probe_timer))
 		afs_dec_servers_outstanding(net);
 }
diff --git a/fs/afs/server.c b/fs/afs/server.c
index c530d1c..8755f27 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -318,7 +318,7 @@ struct afs_server *afs_use_server(struct afs_server *server, bool activate,
 	a = atomic_inc_return(&server->active);
 	if (a == 1 && activate &&
 	    !test_bit(AFS_SERVER_FL_EXPIRED, &server->flags))
-		del_timer(&server->timer);
+		timer_delete(&server->timer);
 
 	trace_afs_server(server->debug_id, r + 1, a, reason);
 	return server;
diff --git a/fs/bcachefs/clock.c b/fs/bcachefs/clock.c
index 1f8e035..d6dd12d 100644
--- a/fs/bcachefs/clock.c
+++ b/fs/bcachefs/clock.c
@@ -121,7 +121,7 @@ void bch2_kthread_io_clock_wait(struct io_clock *clock,
 	} while (0);
 
 	__set_current_state(TASK_RUNNING);
-	del_timer_sync(&wait.cpu_timer);
+	timer_delete_sync(&wait.cpu_timer);
 	destroy_timer_on_stack(&wait.cpu_timer);
 	bch2_io_timer_del(clock, &wait.io_timer);
 }
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index cd5f38d..3541efa 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -225,7 +225,7 @@ void zstd_cleanup_workspace_manager(void)
 	}
 	spin_unlock_bh(&wsm.lock);
 
-	del_timer_sync(&wsm.timer);
+	timer_delete_sync(&wsm.timer);
 }
 
 /*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8122d4f..1819344 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5680,7 +5680,7 @@ failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
 	ext4_stop_mmpd(sbi);
-	del_timer_sync(&sbi->s_err_report);
+	timer_delete_sync(&sbi->s_err_report);
 	ext4_group_desc_free(sbi);
 failed_mount:
 #if IS_ENABLED(CONFIG_UNICODE)
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a5ccba2..743a1d7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -197,7 +197,7 @@ loop:
 	if (journal->j_commit_sequence != journal->j_commit_request) {
 		jbd2_debug(1, "OK, requests differ\n");
 		write_unlock(&journal->j_state_lock);
-		del_timer_sync(&journal->j_commit_timer);
+		timer_delete_sync(&journal->j_commit_timer);
 		jbd2_journal_commit_transaction(journal);
 		write_lock(&journal->j_state_lock);
 		goto loop;
@@ -246,7 +246,7 @@ loop:
 	goto loop;
 
 end_loop:
-	del_timer_sync(&journal->j_commit_timer);
+	timer_delete_sync(&journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
 	jbd2_debug(1, "Journal thread exiting.\n");
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 4061e0b..bb815a0 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -584,7 +584,7 @@ static int __jffs2_flush_wbuf(struct jffs2_sb_info *c, int pad)
 	size_t retlen;
 
 	/* Nothing to do if not write-buffering the flash. In particular, we shouldn't
-	   del_timer() the timer we never initialised. */
+	   call timer_delete() on the timer we never initialised. */
 	if (!jffs2_is_writebuffered(c))
 		return 0;
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3a202e5..83970d9 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2424,7 +2424,7 @@ static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 	 * the area protected by sc_state_lock.
 	 */
 	if (thread_is_alive)
-		del_timer_sync(&sci->sc_timer);
+		timer_delete_sync(&sci->sc_timer);
 }
 
 /**
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 0f46b22..fce9beb 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -724,7 +724,7 @@ static void o2net_shutdown_sc(struct work_struct *work)
 	if (o2net_unregister_callbacks(sc->sc_sock->sk, sc)) {
 		/* we shouldn't flush as we're in the thread, the
 		 * races with pending sc work structs are harmless */
-		del_timer_sync(&sc->sc_idle_timeout);
+		timer_delete_sync(&sc->sc_idle_timeout);
 		o2net_sc_cancel_delayed_work(sc, &sc->sc_keepalive_work);
 		sc_put(sc);
 		kernel_sock_shutdown(sc->sc_sock, SHUT_RDWR);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 557cf9d..f8b9c9c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -563,7 +563,7 @@ void pstore_unregister(struct pstore_info *psi)
 		pstore_unregister_kmsg();
 
 	/* Stop timer and make sure all work has finished. */
-	del_timer_sync(&pstore_timer);
+	timer_delete_sync(&pstore_timer);
 	flush_work(&pstore_work);
 
 	/* Remove all backend records from filesystem tree. */
diff --git a/include/linux/timer.h b/include/linux/timer.h
index e67ecd1..10596d7 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -30,7 +30,7 @@
  *
  * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
  * it's safe to wait for the completion of the running instance from
- * IRQ handlers, for example, by calling del_timer_sync().
+ * IRQ handlers, for example, by calling timer_delete_sync().
  *
  * Note: The irq disabled callback execution is a special case for
  * workqueue locking issues. It's not meant for executing random crap
@@ -168,40 +168,6 @@ extern int timer_delete(struct timer_list *timer);
 extern int timer_shutdown_sync(struct timer_list *timer);
 extern int timer_shutdown(struct timer_list *timer);
 
-/**
- * del_timer_sync - Delete a pending timer and wait for a running callback
- * @timer:	The timer to be deleted
- *
- * See timer_delete_sync() for detailed explanation.
- *
- * Do not use in new code. Use timer_delete_sync() instead.
- *
- * Returns:
- * * %0	- The timer was not pending
- * * %1	- The timer was pending and deactivated
- */
-static inline int del_timer_sync(struct timer_list *timer)
-{
-	return timer_delete_sync(timer);
-}
-
-/**
- * del_timer - Delete a pending timer
- * @timer:	The timer to be deleted
- *
- * See timer_delete() for detailed explanation.
- *
- * Do not use in new code. Use timer_delete() instead.
- *
- * Returns:
- * * %0	- The timer was not pending
- * * %1	- The timer was pending and deactivated
- */
-static inline int del_timer(struct timer_list *timer)
-{
-	return timer_delete(timer);
-}
-
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 84e6b9f..d8da764 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -636,7 +636,7 @@ static inline void sctp_transport_pl_reset(struct sctp_transport *t)
 		}
 	} else {
 		if (t->pl.state != SCTP_PL_DISABLED) {
-			if (del_timer(&t->probe_timer))
+			if (timer_delete(&t->probe_timer))
 				sctp_transport_put(t);
 			t->pl.state = SCTP_PL_DISABLED;
 		}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ac2db99..27f08aa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1695,7 +1695,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		cfile->kn = NULL;
 		spin_unlock_irq(&cgroup_file_kn_lock);
 
-		del_timer_sync(&cfile->notify_timer);
+		timer_delete_sync(&cfile->notify_timer);
 	}
 
 	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 117d9d4..6ce73cc 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1500,7 +1500,7 @@ static int access_thread(void *arg)
 				func();
 		}
 	} while (!torture_must_stop());
-	del_timer_sync(&timer);
+	timer_delete_sync(&timer);
 	destroy_timer_on_stack(&timer);
 
 	torture_kthread_stopping("access_thread");
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5dc5b0d..77c4492 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1362,14 +1362,14 @@ static void kthread_cancel_delayed_work_timer(struct kthread_work *work,
 	struct kthread_worker *worker = work->worker;
 
 	/*
-	 * del_timer_sync() must be called to make sure that the timer
+	 * timer_delete_sync() must be called to make sure that the timer
 	 * callback is not running. The lock must be temporary released
 	 * to avoid a deadlock with the callback. In the meantime,
 	 * any queuing is blocked by setting the canceling counter.
 	 */
 	work->canceling++;
 	raw_spin_unlock_irqrestore(&worker->lock, *flags);
-	del_timer_sync(&dwork->timer);
+	timer_delete_sync(&dwork->timer);
 	raw_spin_lock_irqsave(&worker->lock, *flags);
 	work->canceling--;
 }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6509566..4fa7772 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2324,7 +2324,7 @@ rcu_torture_reader(void *arg)
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
 	if (irqreader && cur_ops->irq_capable) {
-		del_timer_sync(&t);
+		timer_delete_sync(&t);
 		destroy_timer_on_stack(&t);
 	}
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d2a6949..9a59b07 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -690,7 +690,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		del_timer_sync(&sdp->delay_work);
+		timer_delete_sync(&sdp->delay_work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 466668e..c0cc7ae 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1086,7 +1086,7 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	}
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU))
-		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
+		timer_delete_sync(&tasks_rcu_exit_srcu_stall_timer);
 }
 
 /* See if tasks are still holding out, complain if so. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5ff3bc5..fa269d3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -206,7 +206,7 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 
 	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		del_timer(&rdp_gp->nocb_timer);
+		timer_delete(&rdp_gp->nocb_timer);
 	}
 
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
@@ -822,7 +822,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 
 		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
 			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-			del_timer(&my_rdp->nocb_timer);
+			timer_delete(&my_rdp->nocb_timer);
 		}
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index bb56805..1396674 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1440,7 +1440,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
 						group->rtpoll_task,
 						lockdep_is_held(&group->rtpoll_trigger_lock));
 				rcu_assign_pointer(group->rtpoll_task, NULL);
-				del_timer(&group->rtpoll_timer);
+				timer_delete(&group->rtpoll_timer);
 			}
 		}
 		mutex_unlock(&group->rtpoll_trigger_lock);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e0eeacb..bb48498 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -619,7 +619,7 @@ static inline void clocksource_stop_watchdog(void)
 {
 	if (!watchdog_running || (watchdog && !list_empty(&watchdog_list)))
 		return;
-	del_timer(&watchdog_timer);
+	timer_delete(&watchdog_timer);
 	watchdog_running = 0;
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 22376a1..0cf8d39 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1429,7 +1429,7 @@ static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
  * running.
  *
  * This prevents priority inversion: if the soft irq thread is preempted
- * in the middle of a timer callback, then calling del_timer_sync() can
+ * in the middle of a timer callback, then calling hrtimer_cancel() can
  * lead to two issues:
  *
  *  - If the caller is on a remote CPU then it has to spin wait for the timer
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index dfe939f..c0e960a 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -97,7 +97,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	timer.timer.expires = expire;
 	add_timer(&timer.timer);
 	schedule();
-	del_timer_sync(&timer.timer);
+	timer_delete_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
 	destroy_timer_on_stack(&timer.timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c8f776d..4d915c0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -744,7 +744,7 @@ static bool timer_fixup_init(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		timer_delete_sync(timer);
 		debug_object_init(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -790,7 +790,7 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		timer_delete_sync(timer);
 		debug_object_free(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -1212,10 +1212,10 @@ EXPORT_SYMBOL(mod_timer_pending);
  *
  * mod_timer(timer, expires) is equivalent to:
  *
- *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *     timer_delete(timer); timer->expires = expires; add_timer(timer);
  *
  * mod_timer() is more efficient than the above open coded sequence. In
- * case that the timer is inactive, the del_timer() part is a NOP. The
+ * case that the timer is inactive, the timer_delete() part is a NOP. The
  * timer is in any case activated with the new expiry time @expires.
  *
  * Note that if there are multiple unserialized concurrent users of the
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfe030b..cf62032 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2057,11 +2057,11 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		struct delayed_work *dwork = to_delayed_work(work);
 
 		/*
-		 * dwork->timer is irqsafe.  If del_timer() fails, it's
+		 * dwork->timer is irqsafe.  If timer_delete() fails, it's
 		 * guaranteed that the timer is not queued anywhere and not
 		 * running on the local CPU.
 		 */
-		if (likely(del_timer(&dwork->timer)))
+		if (likely(timer_delete(&dwork->timer)))
 			return 1;
 	}
 
@@ -3069,7 +3069,7 @@ restart:
 			break;
 	}
 
-	del_timer_sync(&pool->mayday_timer);
+	timer_delete_sync(&pool->mayday_timer);
 	raw_spin_lock_irq(&pool->lock);
 	/*
 	 * This is necessary even after a new worker was just successfully
@@ -4281,7 +4281,7 @@ EXPORT_SYMBOL_GPL(flush_work);
 bool flush_delayed_work(struct delayed_work *dwork)
 {
 	local_irq_disable();
-	if (del_timer_sync(&dwork->timer))
+	if (timer_delete_sync(&dwork->timer))
 		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
 	local_irq_enable();
 	return flush_work(&dwork->work);
@@ -4984,9 +4984,9 @@ static void put_unbound_pool(struct worker_pool *pool)
 	reap_dying_workers(&cull_list);
 
 	/* shut down the timers */
-	del_timer_sync(&pool->idle_timer);
+	timer_delete_sync(&pool->idle_timer);
 	cancel_work_sync(&pool->idle_cull_work);
-	del_timer_sync(&pool->mayday_timer);
+	timer_delete_sync(&pool->mayday_timer);
 
 	/* RCU protected to allow dereferences from get_work_pool() */
 	call_rcu(&pool->rcu, rcu_free_pool);
@@ -7637,7 +7637,7 @@ notrace void wq_watchdog_touch(int cpu)
 static void wq_watchdog_set_thresh(unsigned long thresh)
 {
 	wq_watchdog_thresh = 0;
-	del_timer_sync(&wq_watchdog_timer);
+	timer_delete_sync(&wq_watchdog_timer);
 
 	if (thresh) {
 		wq_watchdog_thresh = thresh;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e61bbb1..783904d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1151,7 +1151,7 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
-	del_timer_sync(&bdi->laptop_mode_wb_timer);
+	timer_delete_sync(&bdi->laptop_mode_wb_timer);
 
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 18456dd..c81624b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -640,7 +640,7 @@ int wb_domain_init(struct wb_domain *dom, gfp_t gfp)
 #ifdef CONFIG_CGROUP_WRITEBACK
 void wb_domain_exit(struct wb_domain *dom)
 {
-	del_timer_sync(&dom->period_timer);
+	timer_delete_sync(&dom->period_timer);
 	fprop_global_destroy(&dom->completions);
 }
 #endif
@@ -2229,7 +2229,7 @@ void laptop_sync_completion(void)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list)
-		del_timer(&bdi->laptop_mode_wb_timer);
+		timer_delete(&bdi->laptop_mode_wb_timer);
 
 	rcu_read_unlock();
 }
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 05cbb3c..9c787e2 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -856,7 +856,7 @@ int __init aarp_proto_init(void)
 	add_timer(&aarp_timer);
 	rc = register_netdevice_notifier(&aarp_notifier);
 	if (rc) {
-		del_timer_sync(&aarp_timer);
+		timer_delete_sync(&aarp_timer);
 		unregister_snap_client(aarp_dl);
 	}
 	return rc;
@@ -1011,7 +1011,7 @@ const struct seq_operations aarp_seq_ops = {
 /* General module cleanup. Called from cleanup_module() in ddp.c. */
 void aarp_cleanup_module(void)
 {
-	del_timer_sync(&aarp_timer);
+	timer_delete_sync(&aarp_timer);
 	unregister_netdevice_notifier(&aarp_notifier);
 	unregister_snap_client(aarp_dl);
 	aarp_purge();
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 42b910c..61b5b70 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -904,7 +904,7 @@ static void atm_clip_exit_noproc(void)
 	/* First, stop the idle timer, so it stops banging
 	 * on the table.
 	 */
-	del_timer_sync(&idle_timer);
+	timer_delete_sync(&idle_timer);
 
 	dev = clip_devs;
 	while (dev) {
diff --git a/net/atm/lec.c b/net/atm/lec.c
index a948dd4..ded2f0d 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -1302,7 +1302,7 @@ lec_arp_remove(struct lec_priv *priv, struct lec_arp_table *to_remove)
 		return -1;
 
 	hlist_del(&to_remove->next);
-	del_timer(&to_remove->timer);
+	timer_delete(&to_remove->timer);
 
 	/*
 	 * If this is the only MAC connected to this VCC,
@@ -1482,7 +1482,7 @@ static void lec_arp_destroy(struct lec_priv *priv)
 
 	hlist_for_each_entry_safe(entry, next,
 				  &priv->lec_arp_empty_ones, next) {
-		del_timer_sync(&entry->timer);
+		timer_delete_sync(&entry->timer);
 		lec_arp_clear_vccs(entry);
 		hlist_del(&entry->next);
 		lec_arp_put(entry);
@@ -1491,7 +1491,7 @@ static void lec_arp_destroy(struct lec_priv *priv)
 
 	hlist_for_each_entry_safe(entry, next,
 				  &priv->lec_no_forward, next) {
-		del_timer_sync(&entry->timer);
+		timer_delete_sync(&entry->timer);
 		lec_arp_clear_vccs(entry);
 		hlist_del(&entry->next);
 		lec_arp_put(entry);
@@ -1575,7 +1575,7 @@ static void lec_arp_expire_vcc(struct timer_list *t)
 	struct lec_arp_table *to_remove = from_timer(to_remove, t, timer);
 	struct lec_priv *priv = to_remove->priv;
 
-	del_timer(&to_remove->timer);
+	timer_delete(&to_remove->timer);
 
 	pr_debug("%p %p: vpi:%d vci:%d\n",
 		 to_remove, priv,
@@ -1843,16 +1843,16 @@ lec_arp_update(struct lec_priv *priv, const unsigned char *mac_addr,
 					  &priv->lec_arp_empty_ones, next) {
 			if (memcmp(entry->atm_addr, atm_addr, ATM_ESA_LEN) == 0) {
 				hlist_del(&entry->next);
-				del_timer(&entry->timer);
+				timer_delete(&entry->timer);
 				tmp = lec_arp_find(priv, mac_addr);
 				if (tmp) {
-					del_timer(&tmp->timer);
+					timer_delete(&tmp->timer);
 					tmp->status = ESI_FORWARD_DIRECT;
 					memcpy(tmp->atm_addr, atm_addr, ATM_ESA_LEN);
 					tmp->vcc = entry->vcc;
 					tmp->old_push = entry->old_push;
 					tmp->last_used = jiffies;
-					del_timer(&entry->timer);
+					timer_delete(&entry->timer);
 					lec_arp_put(entry);
 					entry = tmp;
 				} else {
@@ -1883,7 +1883,7 @@ lec_arp_update(struct lec_priv *priv, const unsigned char *mac_addr,
 		/* Temporary, changes before end of function */
 	}
 	memcpy(entry->atm_addr, atm_addr, ATM_ESA_LEN);
-	del_timer(&entry->timer);
+	timer_delete(&entry->timer);
 	for (i = 0; i < LEC_ARP_TABLE_SIZE; i++) {
 		hlist_for_each_entry(tmp,
 				     &priv->lec_arp_tables[i], next) {
@@ -1946,7 +1946,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 		entry = make_entry(priv, bus_mac);
 		if (entry == NULL)
 			goto out;
-		del_timer(&entry->timer);
+		timer_delete(&entry->timer);
 		memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
 		entry->recv_vcc = vcc;
 		entry->old_recv_push = old_push;
@@ -1988,7 +1988,7 @@ lec_vcc_added(struct lec_priv *priv, const struct atmlec_ioc *ioc_data,
 					 entry->recv_vcc ? entry->recv_vcc->
 					 vci : 0);
 				found_entry = 1;
-				del_timer(&entry->timer);
+				timer_delete(&entry->timer);
 				entry->vcc = vcc;
 				entry->old_push = old_push;
 				if (entry->status == ESI_VC_PENDING) {
@@ -2172,7 +2172,7 @@ static void lec_vcc_close(struct lec_priv *priv, struct atm_vcc *vcc)
 				  &priv->lec_arp_empty_ones, next) {
 		if (entry->vcc == vcc) {
 			lec_arp_clear_vccs(entry);
-			del_timer(&entry->timer);
+			timer_delete(&entry->timer);
 			hlist_del(&entry->next);
 			lec_arp_put(entry);
 		}
@@ -2182,7 +2182,7 @@ static void lec_vcc_close(struct lec_priv *priv, struct atm_vcc *vcc)
 				  &priv->lec_no_forward, next) {
 		if (entry->recv_vcc == vcc) {
 			lec_arp_clear_vccs(entry);
-			del_timer(&entry->timer);
+			timer_delete(&entry->timer);
 			hlist_del(&entry->next);
 			lec_arp_put(entry);
 		}
@@ -2215,7 +2215,7 @@ lec_arp_check_empties(struct lec_priv *priv,
 	hlist_for_each_entry_safe(entry, next,
 				  &priv->lec_arp_empty_ones, next) {
 		if (vcc == entry->vcc) {
-			del_timer(&entry->timer);
+			timer_delete(&entry->timer);
 			ether_addr_copy(entry->mac_addr, src);
 			entry->status = ESI_FORWARD_DIRECT;
 			entry->last_used = jiffies;
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 12da026..f6b447b 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -804,7 +804,7 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		/* This lets us now how our LECs are doing */
 		err = register_netdevice_notifier(&mpoa_notifier);
 		if (err < 0) {
-			del_timer(&mpc_timer);
+			timer_delete(&mpc_timer);
 			return err;
 		}
 	}
@@ -1495,7 +1495,7 @@ static void __exit atm_mpoa_cleanup(void)
 
 	mpc_proc_clean();
 
-	del_timer_sync(&mpc_timer);
+	timer_delete_sync(&mpc_timer);
 	unregister_netdevice_notifier(&mpoa_notifier);
 	deregister_atm_ioctl(&atm_ioctl_ops);
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 3ee7dba..b790bb9 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1071,11 +1071,11 @@ static int ax25_release(struct socket *sock)
 	}
 	if (ax25_dev) {
 		if (!ax25_dev->device_up) {
-			del_timer_sync(&ax25->timer);
-			del_timer_sync(&ax25->t1timer);
-			del_timer_sync(&ax25->t2timer);
-			del_timer_sync(&ax25->t3timer);
-			del_timer_sync(&ax25->idletimer);
+			timer_delete_sync(&ax25->timer);
+			timer_delete_sync(&ax25->t1timer);
+			timer_delete_sync(&ax25->t2timer);
+			timer_delete_sync(&ax25->t3timer);
+			timer_delete_sync(&ax25->idletimer);
 		}
 		netdev_put(ax25_dev->dev, &ax25->dev_tracker);
 		ax25_dev_put(ax25_dev);
diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
index c4f8adb..8d9fba0 100644
--- a/net/ax25/ax25_ds_timer.c
+++ b/net/ax25/ax25_ds_timer.c
@@ -44,7 +44,7 @@ void ax25_ds_setup_timer(ax25_dev *ax25_dev)
 void ax25_ds_del_timer(ax25_dev *ax25_dev)
 {
 	if (ax25_dev)
-		del_timer(&ax25_dev->dama.slave_timer);
+		timer_delete(&ax25_dev->dama.slave_timer);
 }
 
 void ax25_ds_set_timer(ax25_dev *ax25_dev)
diff --git a/net/ax25/ax25_subr.c b/net/ax25/ax25_subr.c
index 9ff98f4..bff4b20 100644
--- a/net/ax25/ax25_subr.c
+++ b/net/ax25/ax25_subr.c
@@ -262,11 +262,11 @@ void ax25_disconnect(ax25_cb *ax25, int reason)
 	ax25_clear_queues(ax25);
 
 	if (reason == ENETUNREACH) {
-		del_timer_sync(&ax25->timer);
-		del_timer_sync(&ax25->t1timer);
-		del_timer_sync(&ax25->t2timer);
-		del_timer_sync(&ax25->t3timer);
-		del_timer_sync(&ax25->idletimer);
+		timer_delete_sync(&ax25->timer);
+		timer_delete_sync(&ax25->t1timer);
+		timer_delete_sync(&ax25->t2timer);
+		timer_delete_sync(&ax25->t3timer);
+		timer_delete_sync(&ax25->idletimer);
 	} else {
 		if (ax25->sk && !sock_flag(ax25->sk, SOCK_DESTROY))
 			ax25_stop_heartbeat(ax25);
diff --git a/net/ax25/ax25_timer.c b/net/ax25/ax25_timer.c
index 9f7cb0a..3891a39 100644
--- a/net/ax25/ax25_timer.c
+++ b/net/ax25/ax25_timer.c
@@ -65,7 +65,7 @@ void ax25_start_t3timer(ax25_cb *ax25)
 	if (ax25->t3 > 0)
 		mod_timer(&ax25->t3timer, jiffies + ax25->t3);
 	else
-		del_timer(&ax25->t3timer);
+		timer_delete(&ax25->t3timer);
 }
 
 void ax25_start_idletimer(ax25_cb *ax25)
@@ -73,32 +73,32 @@ void ax25_start_idletimer(ax25_cb *ax25)
 	if (ax25->idle > 0)
 		mod_timer(&ax25->idletimer, jiffies + ax25->idle);
 	else
-		del_timer(&ax25->idletimer);
+		timer_delete(&ax25->idletimer);
 }
 
 void ax25_stop_heartbeat(ax25_cb *ax25)
 {
-	del_timer(&ax25->timer);
+	timer_delete(&ax25->timer);
 }
 
 void ax25_stop_t1timer(ax25_cb *ax25)
 {
-	del_timer(&ax25->t1timer);
+	timer_delete(&ax25->t1timer);
 }
 
 void ax25_stop_t2timer(ax25_cb *ax25)
 {
-	del_timer(&ax25->t2timer);
+	timer_delete(&ax25->t2timer);
 }
 
 void ax25_stop_t3timer(ax25_cb *ax25)
 {
-	del_timer(&ax25->t3timer);
+	timer_delete(&ax25->t3timer);
 }
 
 void ax25_stop_idletimer(ax25_cb *ax25)
 {
-	del_timer(&ax25->idletimer);
+	timer_delete(&ax25->idletimer);
 }
 
 int ax25_t1timer_running(ax25_cb *ax25)
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 9fb14e4..adbadb4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -384,13 +384,13 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 	atomic_dec(&tp_vars->bat_priv->tp_num);
 
 	/* kill the timer and remove its reference */
-	del_timer_sync(&tp_vars->timer);
+	timer_delete_sync(&tp_vars->timer);
 	/* the worker might have rearmed itself therefore we kill it again. Note
 	 * that if the worker should run again before invoking the following
-	 * del_timer(), it would not re-arm itself once again because the status
+	 * timer_delete(), it would not re-arm itself once again because the status
 	 * is OFF now
 	 */
-	del_timer(&tp_vars->timer);
+	timer_delete(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 707f229..fc5af86 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -433,7 +433,7 @@ static void hidp_set_timer(struct hidp_session *session)
 static void hidp_del_timer(struct hidp_session *session)
 {
 	if (session->idle_to > 0)
-		del_timer_sync(&session->timer);
+		timer_delete_sync(&session->timer);
 }
 
 static void hidp_process_report(struct hidp_session *session, int type,
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ad5177e..20ea7db 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -254,7 +254,7 @@ static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
 	BT_DBG("session %p state %ld", s, s->state);
 
-	del_timer_sync(&s->timer);
+	timer_delete_sync(&s->timer);
 }
 
 /* ---- RFCOMM DLCs ---- */
@@ -281,7 +281,7 @@ static void rfcomm_dlc_clear_timer(struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p state %ld", d, d->state);
 
-	if (del_timer(&d->timer))
+	if (timer_delete(&d->timer))
 		rfcomm_dlc_put(d);
 }
 
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7e1ad22..722203b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -732,7 +732,7 @@ static int br_mdb_replace_group_sg(const struct br_mdb_config *cfg,
 		mod_timer(&pg->timer,
 			  now + brmctx->multicast_membership_interval);
 	else
-		del_timer(&pg->timer);
+		timer_delete(&pg->timer);
 
 	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
 
@@ -853,7 +853,7 @@ static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
 	    cfg->entry->state == MDB_TEMPORARY)
 		mod_timer(&ent->timer, now + br_multicast_gmi(brmctx));
 	else
-		del_timer(&ent->timer);
+		timer_delete(&ent->timer);
 
 	/* Install a (S, G) forwarding entry for the source. */
 	err = br_mdb_add_group_src_fwd(cfg, &src->addr, brmctx, extack);
@@ -953,7 +953,7 @@ static int br_mdb_replace_group_star_g(const struct br_mdb_config *cfg,
 		mod_timer(&pg->timer,
 			  now + brmctx->multicast_membership_interval);
 	else
-		del_timer(&pg->timer);
+		timer_delete(&pg->timer);
 
 	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2..dcbf058 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -546,7 +546,7 @@ static void br_multicast_fwd_src_add(struct net_bridge_group_src *src)
 		return;
 
 	/* the kernel is now responsible for removing this S,G */
-	del_timer(&sg->timer);
+	timer_delete(&sg->timer);
 	star_mp = br_mdb_ip_get(src->br, &src->pg->key.addr);
 	if (!star_mp)
 		return;
@@ -2015,9 +2015,9 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	del_timer_sync(&pmctx->ip6_mc_router_timer);
+	timer_delete_sync(&pmctx->ip6_mc_router_timer);
 #endif
-	del_timer_sync(&pmctx->ip4_mc_router_timer);
+	timer_delete_sync(&pmctx->ip4_mc_router_timer);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
@@ -2062,7 +2062,7 @@ static void br_multicast_enable(struct bridge_mcast_own_query *query)
 	query->startup_sent = 0;
 
 	if (try_to_del_timer_sync(&query->timer) >= 0 ||
-	    del_timer(&query->timer))
+	    timer_delete(&query->timer))
 		mod_timer(&query->timer, jiffies);
 }
 
@@ -2127,12 +2127,12 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 			br_multicast_find_del_pg(pmctx->port->br, pg);
 
 	del |= br_ip4_multicast_rport_del(pmctx);
-	del_timer(&pmctx->ip4_mc_router_timer);
-	del_timer(&pmctx->ip4_own_query.timer);
+	timer_delete(&pmctx->ip4_mc_router_timer);
+	timer_delete(&pmctx->ip4_own_query.timer);
 	del |= br_ip6_multicast_rport_del(pmctx);
 #if IS_ENABLED(CONFIG_IPV6)
-	del_timer(&pmctx->ip6_mc_router_timer);
-	del_timer(&pmctx->ip6_own_query.timer);
+	timer_delete(&pmctx->ip6_mc_router_timer);
+	timer_delete(&pmctx->ip6_own_query.timer);
 #endif
 	br_multicast_rport_del_notify(pmctx, del);
 }
@@ -4199,15 +4199,15 @@ void br_multicast_open(struct net_bridge *br)
 
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
-	del_timer_sync(&brmctx->ip4_mc_router_timer);
-	del_timer_sync(&brmctx->ip4_other_query.timer);
-	del_timer_sync(&brmctx->ip4_other_query.delay_timer);
-	del_timer_sync(&brmctx->ip4_own_query.timer);
+	timer_delete_sync(&brmctx->ip4_mc_router_timer);
+	timer_delete_sync(&brmctx->ip4_other_query.timer);
+	timer_delete_sync(&brmctx->ip4_other_query.delay_timer);
+	timer_delete_sync(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
-	del_timer_sync(&brmctx->ip6_mc_router_timer);
-	del_timer_sync(&brmctx->ip6_other_query.timer);
-	del_timer_sync(&brmctx->ip6_other_query.delay_timer);
-	del_timer_sync(&brmctx->ip6_own_query.timer);
+	timer_delete_sync(&brmctx->ip6_mc_router_timer);
+	timer_delete_sync(&brmctx->ip6_other_query.timer);
+	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
+	timer_delete_sync(&brmctx->ip6_own_query.timer);
 #endif
 }
 
@@ -4384,9 +4384,9 @@ int br_multicast_set_router(struct net_bridge_mcast *brmctx, unsigned long val)
 	case MDB_RTR_TYPE_DISABLED:
 	case MDB_RTR_TYPE_PERM:
 		br_mc_router_state_change(brmctx->br, val == MDB_RTR_TYPE_PERM);
-		del_timer(&brmctx->ip4_mc_router_timer);
+		timer_delete(&brmctx->ip4_mc_router_timer);
 #if IS_ENABLED(CONFIG_IPV6)
-		del_timer(&brmctx->ip6_mc_router_timer);
+		timer_delete(&brmctx->ip6_mc_router_timer);
 #endif
 		brmctx->multicast_router = val;
 		err = 0;
@@ -4455,10 +4455,10 @@ int br_multicast_set_port_router(struct net_bridge_mcast_port *pmctx,
 	case MDB_RTR_TYPE_DISABLED:
 		pmctx->multicast_router = MDB_RTR_TYPE_DISABLED;
 		del |= br_ip4_multicast_rport_del(pmctx);
-		del_timer(&pmctx->ip4_mc_router_timer);
+		timer_delete(&pmctx->ip4_mc_router_timer);
 		del |= br_ip6_multicast_rport_del(pmctx);
 #if IS_ENABLED(CONFIG_IPV6)
-		del_timer(&pmctx->ip6_mc_router_timer);
+		timer_delete(&pmctx->ip6_mc_router_timer);
 #endif
 		br_multicast_rport_del_notify(pmctx, del);
 		break;
@@ -4470,10 +4470,10 @@ int br_multicast_set_port_router(struct net_bridge_mcast_port *pmctx,
 		break;
 	case MDB_RTR_TYPE_PERM:
 		pmctx->multicast_router = MDB_RTR_TYPE_PERM;
-		del_timer(&pmctx->ip4_mc_router_timer);
+		timer_delete(&pmctx->ip4_mc_router_timer);
 		br_ip4_multicast_add_router(brmctx, pmctx);
 #if IS_ENABLED(CONFIG_IPV6)
-		del_timer(&pmctx->ip6_mc_router_timer);
+		timer_delete(&pmctx->ip6_mc_router_timer);
 #endif
 		br_ip6_multicast_add_router(brmctx, pmctx);
 		break;
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 7d27b2e..024210f 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -198,7 +198,7 @@ void br_become_root_bridge(struct net_bridge *br)
 	br->hello_time = br->bridge_hello_time;
 	br->forward_delay = br->bridge_forward_delay;
 	br_topology_change_detection(br);
-	del_timer(&br->tcn_timer);
+	timer_delete(&br->tcn_timer);
 
 	if (br->dev->flags & IFF_UP) {
 		br_config_bpdu_generation(br);
@@ -363,7 +363,7 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
 static void br_topology_change_acknowledged(struct net_bridge *br)
 {
 	br->topology_change_detected = 0;
-	del_timer(&br->tcn_timer);
+	timer_delete(&br->tcn_timer);
 }
 
 /* called under bridge lock */
@@ -439,7 +439,7 @@ static void br_make_blocking(struct net_bridge_port *p)
 		br_set_state(p, BR_STATE_BLOCKING);
 		br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
-		del_timer(&p->forward_delay_timer);
+		timer_delete(&p->forward_delay_timer);
 	}
 }
 
@@ -454,7 +454,7 @@ static void br_make_forwarding(struct net_bridge_port *p)
 	if (br->stp_enabled == BR_NO_STP || br->forward_delay == 0) {
 		br_set_state(p, BR_STATE_FORWARDING);
 		br_topology_change_detection(br);
-		del_timer(&p->forward_delay_timer);
+		timer_delete(&p->forward_delay_timer);
 	} else if (br->stp_enabled == BR_KERNEL_STP)
 		br_set_state(p, BR_STATE_LISTENING);
 	else
@@ -483,7 +483,7 @@ void br_port_state_selection(struct net_bridge *br)
 				p->topology_change_ack = 0;
 				br_make_forwarding(p);
 			} else if (br_is_designated_port(p)) {
-				del_timer(&p->message_age_timer);
+				timer_delete(&p->message_age_timer);
 				br_make_forwarding(p);
 			} else {
 				p->config_pending = 0;
@@ -533,9 +533,9 @@ void br_received_config_bpdu(struct net_bridge_port *p,
 		br_port_state_selection(br);
 
 		if (!br_is_root_bridge(br) && was_root) {
-			del_timer(&br->hello_timer);
+			timer_delete(&br->hello_timer);
 			if (br->topology_change_detected) {
-				del_timer(&br->topology_change_timer);
+				timer_delete(&br->topology_change_timer);
 				br_transmit_tcn(br);
 
 				mod_timer(&br->tcn_timer,
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d3..c20a41b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -81,9 +81,9 @@ void br_stp_disable_bridge(struct net_bridge *br)
 	br->topology_change_detected = 0;
 	spin_unlock_bh(&br->lock);
 
-	del_timer_sync(&br->hello_timer);
-	del_timer_sync(&br->topology_change_timer);
-	del_timer_sync(&br->tcn_timer);
+	timer_delete_sync(&br->hello_timer);
+	timer_delete_sync(&br->topology_change_timer);
+	timer_delete_sync(&br->tcn_timer);
 	cancel_delayed_work_sync(&br->gc_work);
 }
 
@@ -109,9 +109,9 @@ void br_stp_disable_port(struct net_bridge_port *p)
 
 	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
-	del_timer(&p->message_age_timer);
-	del_timer(&p->forward_delay_timer);
-	del_timer(&p->hold_timer);
+	timer_delete(&p->message_age_timer);
+	timer_delete(&p->forward_delay_timer);
+	timer_delete(&p->hold_timer);
 
 	if (!rcu_access_pointer(p->backup_port))
 		br_fdb_delete_by_port(br, p, 0, 0);
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 4c059e4..4aab703 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -825,7 +825,7 @@ static void can_pernet_exit(struct net *net)
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		can_remove_proc(net);
 		if (stats_timer)
-			del_timer_sync(&net->can.stattimer);
+			timer_delete_sync(&net->can.stattimer);
 	}
 
 	kfree(net->can.rx_alldev_list);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 212f0a0..8a7ce64 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1088,7 +1088,7 @@ err_module_put:
 		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		del_timer_sync(&hw_data->send_timer);
+		timer_delete_sync(&hw_data->send_timer);
 		cancel_work_sync(&hw_data->dm_alert_work);
 		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
 			struct devlink_trap_metadata *hw_metadata;
@@ -1122,7 +1122,7 @@ static void net_dm_hw_monitor_stop(struct netlink_ext_ack *extack)
 		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		del_timer_sync(&hw_data->send_timer);
+		timer_delete_sync(&hw_data->send_timer);
 		cancel_work_sync(&hw_data->dm_alert_work);
 		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
 			struct devlink_trap_metadata *hw_metadata;
@@ -1183,7 +1183,7 @@ err_module_put:
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		del_timer_sync(&data->send_timer);
+		timer_delete_sync(&data->send_timer);
 		cancel_work_sync(&data->dm_alert_work);
 		while ((skb = __skb_dequeue(&data->drop_queue)))
 			consume_skb(skb);
@@ -1211,7 +1211,7 @@ static void net_dm_trace_off_set(void)
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		del_timer_sync(&data->send_timer);
+		timer_delete_sync(&data->send_timer);
 		cancel_work_sync(&data->dm_alert_work);
 		while ((skb = __skb_dequeue(&data->drop_queue)))
 			consume_skb(skb);
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index 4128160..2b821b9 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -177,7 +177,7 @@ int gen_new_estimator(struct gnet_stats_basic_sync *bstats,
 		spin_lock_bh(lock);
 	old = rcu_dereference_protected(*rate_est, 1);
 	if (old) {
-		del_timer_sync(&old->timer);
+		timer_delete_sync(&old->timer);
 		est->avbps = old->avbps;
 		est->avpps = old->avpps;
 	}
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0738aa6..a07249b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -309,7 +309,7 @@ static void neigh_add_timer(struct neighbour *n, unsigned long when)
 static int neigh_del_timer(struct neighbour *n)
 {
 	if ((n->nud_state & NUD_IN_TIMER) &&
-	    del_timer(&n->timer)) {
+	    timer_delete(&n->timer)) {
 		neigh_release(n);
 		return 1;
 	}
@@ -427,7 +427,7 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
-		del_timer_sync(&tbl->proxy_timer);
+		timer_delete_sync(&tbl->proxy_timer);
 	return 0;
 }
 
@@ -1597,7 +1597,7 @@ static void neigh_proxy_process(struct timer_list *t)
 		} else if (!sched_next || tdif < sched_next)
 			sched_next = tdif;
 	}
-	del_timer(&tbl->proxy_timer);
+	timer_delete(&tbl->proxy_timer);
 	if (sched_next)
 		mod_timer(&tbl->proxy_timer, jiffies + sched_next);
 	spin_unlock(&tbl->proxy_queue.lock);
@@ -1628,7 +1628,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 	NEIGH_CB(skb)->flags |= LOCALLY_ENQUEUED;
 
 	spin_lock(&tbl->proxy_queue.lock);
-	if (del_timer(&tbl->proxy_timer)) {
+	if (timer_delete(&tbl->proxy_timer)) {
 		if (time_before(tbl->proxy_timer.expires, sched_next))
 			sched_next = tbl->proxy_timer.expires;
 	}
@@ -1786,7 +1786,7 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
-	del_timer_sync(&tbl->proxy_timer);
+	timer_delete_sync(&tbl->proxy_timer);
 	pneigh_queue_purge(&tbl->proxy_queue, NULL, tbl->family);
 	neigh_ifdown(tbl, NULL);
 	if (atomic_read(&tbl->entries))
diff --git a/net/core/sock.c b/net/core/sock.c
index 3238920..f67a3c5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3598,14 +3598,14 @@ EXPORT_SYMBOL(sk_reset_timer);
 
 void sk_stop_timer(struct sock *sk, struct timer_list* timer)
 {
-	if (del_timer(timer))
+	if (timer_delete(timer))
 		__sock_put(sk);
 }
 EXPORT_SYMBOL(sk_stop_timer);
 
 void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer)
 {
-	if (del_timer_sync(timer))
+	if (timer_delete_sync(timer))
 		__sock_put(sk);
 }
 EXPORT_SYMBOL(sk_stop_timer_sync);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 2c394c3..ca7d539 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -205,7 +205,7 @@ static void ip_sf_list_clear_all(struct ip_sf_list *psf)
 static void igmp_stop_timer(struct ip_mc_list *im)
 {
 	spin_lock_bh(&im->lock);
-	if (del_timer(&im->timer))
+	if (timer_delete(&im->timer))
 		refcount_dec(&im->refcnt);
 	im->tm_running = 0;
 	im->reporter = 0;
@@ -251,7 +251,7 @@ static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 {
 	spin_lock_bh(&im->lock);
 	im->unsolicit_count = 0;
-	if (del_timer(&im->timer)) {
+	if (timer_delete(&im->timer)) {
 		if ((long)(im->timer.expires-jiffies) < max_delay) {
 			add_timer(&im->timer);
 			im->tm_running = 1;
@@ -974,7 +974,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		}
 		/* cancel the interface change timer */
 		WRITE_ONCE(in_dev->mr_ifc_count, 0);
-		if (del_timer(&in_dev->mr_ifc_timer))
+		if (timer_delete(&in_dev->mr_ifc_timer))
 			__in_dev_put(in_dev);
 		/* clear deleted report items */
 		igmpv3_clear_delrec(in_dev);
@@ -1830,10 +1830,10 @@ void ip_mc_down(struct in_device *in_dev)
 
 #ifdef CONFIG_IP_MULTICAST
 	WRITE_ONCE(in_dev->mr_ifc_count, 0);
-	if (del_timer(&in_dev->mr_ifc_timer))
+	if (timer_delete(&in_dev->mr_ifc_timer))
 		__in_dev_put(in_dev);
 	in_dev->mr_gq_running = 0;
-	if (del_timer(&in_dev->mr_gq_timer))
+	if (timer_delete(&in_dev->mr_gq_timer))
 		__in_dev_put(in_dev);
 #endif
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 19fae48..470ab17 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -133,7 +133,7 @@ static void inet_frags_free_cb(void *ptr, void *arg)
 	struct inet_frag_queue *fq = ptr;
 	int count;
 
-	count = del_timer_sync(&fq->timer) ? 1 : 0;
+	count = timer_delete_sync(&fq->timer) ? 1 : 0;
 
 	spin_lock_bh(&fq->lock);
 	fq->flags |= INET_FRAG_DROP;
@@ -227,7 +227,7 @@ EXPORT_SYMBOL(fqdir_exit);
 
 void inet_frag_kill(struct inet_frag_queue *fq, int *refs)
 {
-	if (del_timer(&fq->timer))
+	if (timer_delete(&fq->timer))
 		(*refs)++;
 
 	if (!(fq->flags & INET_FRAG_COMPLETE)) {
@@ -297,7 +297,7 @@ void inet_frag_destroy(struct inet_frag_queue *q)
 	reason = (q->flags & INET_FRAG_DROP) ?
 			SKB_DROP_REASON_FRAG_REASM_TIMEOUT :
 			SKB_CONSUMED;
-	WARN_ON(del_timer(&q->timer) != 0);
+	WARN_ON(timer_delete(&q->timer) != 0);
 
 	/* Release all fragment data. */
 	fqdir = q->fqdir;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b81c813..a8b04d4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1289,7 +1289,7 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 		}
 	}
 	if (list_empty(&mrt->mfc_unres_queue))
-		del_timer(&mrt->ipmr_expire_timer);
+		timer_delete(&mrt->ipmr_expire_timer);
 	spin_unlock_bh(&mfc_unres_lock);
 
 	if (found) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc10..5b88e40 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -312,7 +312,7 @@ static inline bool addrconf_link_ready(const struct net_device *dev)
 
 static void addrconf_del_rs_timer(struct inet6_dev *idev)
 {
-	if (del_timer(&idev->rs_timer))
+	if (timer_delete(&idev->rs_timer))
 		__in6_dev_put(idev);
 }
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index c134ba2..bf72714 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2383,7 +2383,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  round_jiffies(now
 					+ net->ipv6.sysctl.ip6_rt_gc_interval));
 	else
-		del_timer(&net->ipv6.ip6_fib_timer);
+		timer_delete(&net->ipv6.ip6_fib_timer);
 	spin_unlock_bh(&net->ipv6.fib6_gc_lock);
 }
 
@@ -2470,7 +2470,7 @@ static void fib6_net_exit(struct net *net)
 {
 	unsigned int i;
 
-	del_timer_sync(&net->ipv6.ip6_fib_timer);
+	timer_delete_sync(&net->ipv6.ip6_fib_timer);
 
 	for (i = 0; i < FIB6_TABLE_HASHSZ; i++) {
 		struct hlist_head *head = &net->ipv6.fib_table_hash[i];
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index eca07e1..a3ff575 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -907,6 +907,6 @@ int ip6_flowlabel_init(void)
 void ip6_flowlabel_cleanup(void)
 {
 	static_key_deferred_flush(&ipv6_flowlabel_exclusive);
-	del_timer(&ip6_fl_gc_timer);
+	timer_delete(&ip6_fl_gc_timer);
 	unregister_pernet_subsys(&ip6_flowlabel_net_ops);
 }
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e8ade93..b413c9c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1526,7 +1526,7 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 		}
 	}
 	if (list_empty(&mrt->mfc_unres_queue))
-		del_timer(&mrt->ipmr_expire_timer);
+		timer_delete(&mrt->ipmr_expire_timer);
 	spin_unlock_bh(&mfc_unres_lock);
 
 	if (found) {
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 0971ca4..a0596e1 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -194,8 +194,8 @@ int lapb_unregister(struct net_device *dev)
 	spin_unlock_bh(&lapb->lock);
 
 	/* Wait for running timers to stop */
-	del_timer_sync(&lapb->t1timer);
-	del_timer_sync(&lapb->t2timer);
+	timer_delete_sync(&lapb->t1timer);
+	timer_delete_sync(&lapb->t2timer);
 
 	__lapb_remove_cb(lapb);
 
diff --git a/net/lapb/lapb_timer.c b/net/lapb/lapb_timer.c
index 5be6886..5b3f3b4 100644
--- a/net/lapb/lapb_timer.c
+++ b/net/lapb/lapb_timer.c
@@ -35,7 +35,7 @@ static void lapb_t2timer_expiry(struct timer_list *);
 
 void lapb_start_t1timer(struct lapb_cb *lapb)
 {
-	del_timer(&lapb->t1timer);
+	timer_delete(&lapb->t1timer);
 
 	lapb->t1timer.function = lapb_t1timer_expiry;
 	lapb->t1timer.expires  = jiffies + lapb->t1;
@@ -46,7 +46,7 @@ void lapb_start_t1timer(struct lapb_cb *lapb)
 
 void lapb_start_t2timer(struct lapb_cb *lapb)
 {
-	del_timer(&lapb->t2timer);
+	timer_delete(&lapb->t2timer);
 
 	lapb->t2timer.function = lapb_t2timer_expiry;
 	lapb->t2timer.expires  = jiffies + lapb->t2;
@@ -58,13 +58,13 @@ void lapb_start_t2timer(struct lapb_cb *lapb)
 void lapb_stop_t1timer(struct lapb_cb *lapb)
 {
 	lapb->t1timer_running = false;
-	del_timer(&lapb->t1timer);
+	timer_delete(&lapb->t1timer);
 }
 
 void lapb_stop_t2timer(struct lapb_cb *lapb)
 {
 	lapb->t2timer_running = false;
-	del_timer(&lapb->t2timer);
+	timer_delete(&lapb->t2timer);
 }
 
 int lapb_t1timer_running(struct lapb_cb *lapb)
diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
index 40ca3c1..7e8fc71 100644
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -51,7 +51,7 @@ int llc_conn_ac_clear_remote_busy(struct sock *sk, struct sk_buff *skb)
 		struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
 
 		llc->remote_busy_flag = 0;
-		del_timer(&llc->busy_state_timer.timer);
+		timer_delete(&llc->busy_state_timer.timer);
 		nr = LLC_I_GET_NR(pdu);
 		llc_conn_resend_i_pdu_as_cmd(sk, nr, 0);
 	}
@@ -191,7 +191,7 @@ int llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2(struct sock *sk,
 	struct llc_sock *llc = llc_sk(sk);
 
 	if (llc->data_flag == 2)
-		del_timer(&llc->rej_sent_timer.timer);
+		timer_delete(&llc->rej_sent_timer.timer);
 	return 0;
 }
 
@@ -1111,9 +1111,9 @@ int llc_conn_ac_stop_other_timers(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	del_timer(&llc->rej_sent_timer.timer);
-	del_timer(&llc->pf_cycle_timer.timer);
-	del_timer(&llc->busy_state_timer.timer);
+	timer_delete(&llc->rej_sent_timer.timer);
+	timer_delete(&llc->pf_cycle_timer.timer);
+	timer_delete(&llc->busy_state_timer.timer);
 	llc->ack_must_be_send = 0;
 	llc->ack_pf = 0;
 	return 0;
@@ -1149,7 +1149,7 @@ int llc_conn_ac_start_ack_tmr_if_not_running(struct sock *sk,
 
 int llc_conn_ac_stop_ack_timer(struct sock *sk, struct sk_buff *skb)
 {
-	del_timer(&llc_sk(sk)->ack_timer.timer);
+	timer_delete(&llc_sk(sk)->ack_timer.timer);
 	return 0;
 }
 
@@ -1157,14 +1157,14 @@ int llc_conn_ac_stop_p_timer(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	del_timer(&llc->pf_cycle_timer.timer);
+	timer_delete(&llc->pf_cycle_timer.timer);
 	llc_conn_set_p_flag(sk, 0);
 	return 0;
 }
 
 int llc_conn_ac_stop_rej_timer(struct sock *sk, struct sk_buff *skb)
 {
-	del_timer(&llc_sk(sk)->rej_sent_timer.timer);
+	timer_delete(&llc_sk(sk)->rej_sent_timer.timer);
 	return 0;
 }
 
@@ -1180,7 +1180,7 @@ int llc_conn_ac_upd_nr_received(struct sock *sk, struct sk_buff *skb)
 	/* On loopback we don't queue I frames in unack_pdu_q queue. */
 	if (acked > 0 || (llc->dev->flags & IFF_LOOPBACK)) {
 		llc->retry_count = 0;
-		del_timer(&llc->ack_timer.timer);
+		timer_delete(&llc->ack_timer.timer);
 		if (llc->failed_data_req) {
 			/* already, we did not accept data from upper layer
 			 * (tx_window full or unacceptable state). Now, we
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index afc6974..5c0ac24 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -949,15 +949,15 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
 	struct llc_sock *llc = llc_sk(sk);
 
 	if (sync) {
-		del_timer_sync(&llc->pf_cycle_timer.timer);
-		del_timer_sync(&llc->ack_timer.timer);
-		del_timer_sync(&llc->rej_sent_timer.timer);
-		del_timer_sync(&llc->busy_state_timer.timer);
+		timer_delete_sync(&llc->pf_cycle_timer.timer);
+		timer_delete_sync(&llc->ack_timer.timer);
+		timer_delete_sync(&llc->rej_sent_timer.timer);
+		timer_delete_sync(&llc->busy_state_timer.timer);
 	} else {
-		del_timer(&llc->pf_cycle_timer.timer);
-		del_timer(&llc->ack_timer.timer);
-		del_timer(&llc->rej_sent_timer.timer);
-		del_timer(&llc->busy_state_timer.timer);
+		timer_delete(&llc->pf_cycle_timer.timer);
+		timer_delete(&llc->ack_timer.timer);
+		timer_delete(&llc->rej_sent_timer.timer);
+		timer_delete(&llc->busy_state_timer.timer);
 	}
 
 	llc->ack_must_be_send = 0;
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index aeb99d1..8561223 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -103,13 +103,13 @@ void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	del_timer_sync(&tid_rx->session_timer);
+	timer_delete_sync(&tid_rx->session_timer);
 
 	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
 	spin_lock_bh(&tid_rx->reorder_lock);
 	tid_rx->removed = true;
 	spin_unlock_bh(&tid_rx->reorder_lock);
-	del_timer_sync(&tid_rx->reorder_timer);
+	timer_delete_sync(&tid_rx->reorder_timer);
 
 	call_rcu(&tid_rx->rcu_head, ieee80211_free_tid_rx);
 }
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 63a5e48..8dc8c3c 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -362,8 +362,8 @@ int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 	ht_dbg(sta->sdata, "Tx BA session stop requested for %pM tid %u\n",
 	       sta->sta.addr, tid);
 
-	del_timer_sync(&tid_tx->addba_resp_timer);
-	del_timer_sync(&tid_tx->session_timer);
+	timer_delete_sync(&tid_tx->addba_resp_timer);
+	timer_delete_sync(&tid_tx->session_timer);
 
 	/*
 	 * After this packets are no longer handed right through
@@ -1002,7 +1002,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 		return;
 	}
 
-	del_timer_sync(&tid_tx->addba_resp_timer);
+	timer_delete_sync(&tid_tx->addba_resp_timer);
 
 	ht_dbg(sta->sdata, "switched off addBA timer for %pM tid %d\n",
 	       sta->sta.addr, tid);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 05a945d..4246d16 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1844,7 +1844,7 @@ int ieee80211_ibss_leave(struct ieee80211_sub_if_data *sdata)
 
 	skb_queue_purge(&sdata->skb_queue);
 
-	del_timer_sync(&sdata->u.ibss.timer);
+	timer_delete_sync(&sdata->u.ibss.timer);
 
 	return 0;
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b042304..f0f4a25 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -526,7 +526,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		netif_addr_unlock_bh(sdata->dev);
 	}
 
-	del_timer_sync(&local->dynamic_ps_timer);
+	timer_delete_sync(&local->dynamic_ps_timer);
 	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
 	WARN(ieee80211_vif_is_mld(&sdata->vif),
diff --git a/net/mac80211/led.c b/net/mac80211/led.c
index 2dc7321..885fa6a 100644
--- a/net/mac80211/led.c
+++ b/net/mac80211/led.c
@@ -342,7 +342,7 @@ static void ieee80211_stop_tpt_led_trig(struct ieee80211_local *local)
 		return;
 
 	tpt_trig->running = false;
-	del_timer_sync(&tpt_trig->timer);
+	timer_delete_sync(&tpt_trig->timer);
 
 	led_trigger_event(&local->tpt_led, LED_OFF);
 }
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 9740813..7257f56 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -706,7 +706,7 @@ void ieee80211_mesh_root_setup(struct ieee80211_if_mesh *ifmsh)
 	else {
 		clear_bit(MESH_WORK_ROOT, &ifmsh->wrkq_flags);
 		/* stop running timer */
-		del_timer_sync(&ifmsh->mesh_path_root_timer);
+		timer_delete_sync(&ifmsh->mesh_path_root_timer);
 	}
 }
 
@@ -1241,9 +1241,9 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	local->total_ps_buffered -= skb_queue_len(&ifmsh->ps.bc_buf);
 	skb_queue_purge(&ifmsh->ps.bc_buf);
 
-	del_timer_sync(&sdata->u.mesh.housekeeping_timer);
-	del_timer_sync(&sdata->u.mesh.mesh_path_root_timer);
-	del_timer_sync(&sdata->u.mesh.mesh_path_timer);
+	timer_delete_sync(&sdata->u.mesh.housekeeping_timer);
+	timer_delete_sync(&sdata->u.mesh.mesh_path_root_timer);
+	timer_delete_sync(&sdata->u.mesh.mesh_path_timer);
 
 	/* clear any mesh work (for next join) we may have accrued */
 	ifmsh->wrkq_flags = 0;
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 5a0156e..96e0a86 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -417,7 +417,7 @@ u64 mesh_plink_deactivate(struct sta_info *sta)
 	}
 	spin_unlock_bh(&sta->mesh->plink_lock);
 	if (!sdata->u.mesh.user_mpm)
-		del_timer_sync(&sta->mesh->plink_timer);
+		timer_delete_sync(&sta->mesh->plink_timer);
 	mesh_path_flush_by_nexthop(sta);
 
 	/* make sure no readers can access nexthop sta from here on */
@@ -666,7 +666,7 @@ void mesh_plink_timer(struct timer_list *t)
 
 	/*
 	 * This STA is valid because sta_info_destroy() will
-	 * del_timer_sync() this timer after having made sure
+	 * timer_delete_sync() this timer after having made sure
 	 * it cannot be re-added (by deleting the plink.)
 	 */
 	sta = mesh->plink_sta;
@@ -689,7 +689,7 @@ void mesh_plink_timer(struct timer_list *t)
 		return;
 	}
 
-	/* del_timer() and handler may race when entering these states */
+	/* timer_delete() and handler may race when entering these states */
 	if (sta->mesh->plink_state == NL80211_PLINK_LISTEN ||
 	    sta->mesh->plink_state == NL80211_PLINK_ESTAB) {
 		mpl_dbg(sta->sdata,
@@ -735,7 +735,7 @@ void mesh_plink_timer(struct timer_list *t)
 		break;
 	case NL80211_PLINK_HOLDING:
 		/* holding timer */
-		del_timer(&sta->mesh->plink_timer);
+		timer_delete(&sta->mesh->plink_timer);
 		mesh_plink_fsm_restart(sta);
 		break;
 	default:
@@ -848,7 +848,7 @@ static u64 mesh_plink_establish(struct ieee80211_sub_if_data *sdata,
 	struct mesh_config *mshcfg = &sdata->u.mesh.mshcfg;
 	u64 changed = 0;
 
-	del_timer(&sta->mesh->plink_timer);
+	timer_delete(&sta->mesh->plink_timer);
 	sta->mesh->plink_state = NL80211_PLINK_ESTAB;
 	changed |= mesh_plink_inc_estab_count(sdata);
 	changed |= mesh_set_ht_prot_mode(sdata);
@@ -975,7 +975,7 @@ static u64 mesh_plink_fsm(struct ieee80211_sub_if_data *sdata,
 	case NL80211_PLINK_HOLDING:
 		switch (event) {
 		case CLS_ACPT:
-			del_timer(&sta->mesh->plink_timer);
+			timer_delete(&sta->mesh->plink_timer);
 			mesh_plink_fsm_restart(sta);
 			break;
 		case OPN_ACPT:
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c010bb3..5d1f2d6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3194,7 +3194,7 @@ static void ieee80211_change_ps(struct ieee80211_local *local)
 	} else if (conf->flags & IEEE80211_CONF_PS) {
 		conf->flags &= ~IEEE80211_CONF_PS;
 		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
-		del_timer_sync(&local->dynamic_ps_timer);
+		timer_delete_sync(&local->dynamic_ps_timer);
 		wiphy_work_cancel(local->hw.wiphy,
 				  &local->dynamic_ps_enable_work);
 	}
@@ -4069,7 +4069,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
-	del_timer_sync(&local->dynamic_ps_timer);
+	timer_delete_sync(&local->dynamic_ps_timer);
 	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
 	/* Disable ARP filtering */
@@ -4097,9 +4097,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	/* disassociated - set to defaults now */
 	ieee80211_set_wmm_default(&sdata->deflink, false, false);
 
-	del_timer_sync(&sdata->u.mgd.conn_mon_timer);
-	del_timer_sync(&sdata->u.mgd.bcn_mon_timer);
-	del_timer_sync(&sdata->u.mgd.timer);
+	timer_delete_sync(&sdata->u.mgd.conn_mon_timer);
+	timer_delete_sync(&sdata->u.mgd.bcn_mon_timer);
+	timer_delete_sync(&sdata->u.mgd.timer);
 
 	sdata->vif.bss_conf.dtim_period = 0;
 	sdata->vif.bss_conf.beacon_rate = NULL;
@@ -4589,7 +4589,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		 * running is the timeout for the authentication response which
 		 * which is not relevant anymore.
 		 */
-		del_timer_sync(&sdata->u.mgd.timer);
+		timer_delete_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, auth_data->ap_addr);
 
 		/* other links are destroyed */
@@ -4628,7 +4628,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		 * running is the timeout for the association response which
 		 * which is not relevant anymore.
 		 */
-		del_timer_sync(&sdata->u.mgd.timer);
+		timer_delete_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, assoc_data->ap_addr);
 
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
@@ -9852,7 +9852,7 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	ifmgd->assoc_req_ies = NULL;
 	ifmgd->assoc_req_ies_len = 0;
 	spin_unlock_bh(&ifmgd->teardown_lock);
-	del_timer_sync(&ifmgd->timer);
+	timer_delete_sync(&ifmgd->timer);
 }
 
 void ieee80211_cqm_rssi_notify(struct ieee80211_vif *vif,
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 6218abc..ece1e83 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -230,7 +230,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 
 	skb_queue_purge(&sdata->skb_queue);
 
-	del_timer_sync(&sdata->u.ocb.housekeeping_timer);
+	timer_delete_sync(&sdata->u.ocb.housekeeping_timer);
 	/* If the timer fired while we waited for it, it will have
 	 * requeued the work. Now the work will be running again
 	 * but will not rearm the timer again because it checks
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 29fab7a..2b9abc2 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -30,9 +30,9 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 
 	/* FIXME: what to do when local->pspolling is true? */
 
-	del_timer_sync(&local->dynamic_ps_timer);
-	del_timer_sync(&ifmgd->bcn_mon_timer);
-	del_timer_sync(&ifmgd->conn_mon_timer);
+	timer_delete_sync(&local->dynamic_ps_timer);
+	timer_delete_sync(&ifmgd->bcn_mon_timer);
+	timer_delete_sync(&ifmgd->conn_mon_timer);
 
 	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 7be5234..a9cc832 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -69,14 +69,14 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	flush_workqueue(local->workqueue);
 
 	/* Don't try to run timers while suspended. */
-	del_timer_sync(&local->sta_cleanup);
+	timer_delete_sync(&local->sta_cleanup);
 
 	 /*
 	 * Note that this particular timer doesn't need to be
 	 * restarted at resume.
 	 */
 	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
-	del_timer_sync(&local->dynamic_ps_timer);
+	timer_delete_sync(&local->dynamic_ps_timer);
 
 	local->wowlan = wowlan;
 	if (local->wowlan) {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f7f89cd..09beb65 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1242,7 +1242,7 @@ static void ieee80211_sta_reorder_release(struct ieee80211_sub_if_data *sdata,
 				  tid_agg_rx->reorder_time[j] + 1 +
 				  HT_RX_REORDER_BUF_TIMEOUT);
 	} else {
-		del_timer(&tid_agg_rx->reorder_timer);
+		timer_delete(&tid_agg_rx->reorder_timer);
 	}
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 30cdc78..248e1f6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1592,7 +1592,7 @@ int sta_info_init(struct ieee80211_local *local)
 
 void sta_info_stop(struct ieee80211_local *local)
 {
-	del_timer_sync(&local->sta_cleanup);
+	timer_delete_sync(&local->sta_cleanup);
 	rhltable_destroy(&local->sta_hash);
 	rhltable_destroy(&local->link_sta_hash);
 }
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index f6de136..dd89561 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -663,7 +663,7 @@ static void mctp_sk_unhash(struct sock *sk)
 	 * keys), stop any pending expiry events. the timer cannot be re-queued
 	 * as the sk is no longer observable
 	 */
-	del_timer_sync(&msk->key_expiry);
+	timer_delete_sync(&msk->key_expiry);
 }
 
 static void mctp_sk_destruct(struct sock *sk)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 18b19db..31747f9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -327,7 +327,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	/* no lock, because sk_stop_timer_sync() is calling timer_delete_sync() */
 	if (add_timer)
 		sk_stop_timer_sync(sk, add_timer);
 
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 7891a53..b369470 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -189,7 +189,7 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
 	nc->monitor.enabled = false;
 	spin_unlock_irqrestore(&nc->lock, flags);
 
-	del_timer_sync(&nc->monitor.timer);
+	timer_delete_sync(&nc->monitor.timer);
 }
 
 struct ncsi_channel *ncsi_find_channel(struct ncsi_package *np,
@@ -396,7 +396,7 @@ void ncsi_free_request(struct ncsi_request *nr)
 
 	if (nr->enabled) {
 		nr->enabled = false;
-		del_timer_sync(&nr->timer);
+		timer_delete_sync(&nr->timer);
 	}
 
 	spin_lock_irqsave(&ndp->lock, flags);
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index cb48a2b..6ae042f 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -294,7 +294,7 @@ mtype_cancel_gc(struct ip_set *set)
 	struct mtype *map = set->data;
 
 	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
+		timer_delete_sync(&map->gc);
 }
 
 static const struct ip_set_type_variant mtype = {
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 20a1727..8699944 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -822,7 +822,7 @@ static void ip_vs_conn_rcu_free(struct rcu_head *head)
 /* Try to delete connection while not holding reference */
 static void ip_vs_conn_del(struct ip_vs_conn *cp)
 {
-	if (del_timer(&cp->timer)) {
+	if (timer_delete(&cp->timer)) {
 		/* Drop cp->control chain too */
 		if (cp->control)
 			cp->timeout = 0;
@@ -833,7 +833,7 @@ static void ip_vs_conn_del(struct ip_vs_conn *cp)
 /* Try to delete connection while holding reference */
 static void ip_vs_conn_del_put(struct ip_vs_conn *cp)
 {
-	if (del_timer(&cp->timer)) {
+	if (timer_delete(&cp->timer)) {
 		/* Drop cp->control chain too */
 		if (cp->control)
 			cp->timeout = 0;
@@ -860,7 +860,7 @@ static void ip_vs_conn_expire(struct timer_list *t)
 		struct ip_vs_conn *ct = cp->control;
 
 		/* delete the timer if it is activated by other users */
-		del_timer(&cp->timer);
+		timer_delete(&cp->timer);
 
 		/* does anybody control me? */
 		if (ct) {
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 0633276..7d5b741 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -848,7 +848,7 @@ static void ip_vs_trash_cleanup(struct netns_ipvs *ipvs)
 {
 	struct ip_vs_dest *dest, *nxt;
 
-	del_timer_sync(&ipvs->dest_trash_timer);
+	timer_delete_sync(&ipvs->dest_trash_timer);
 	/* No need to use dest_trash_lock */
 	list_for_each_entry_safe(dest, nxt, &ipvs->dest_trash, t_list) {
 		list_del(&dest->t_list);
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 21fa550..21d22fa 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -118,7 +118,7 @@ nf_ct_exp_equal(const struct nf_conntrack_tuple *tuple,
 
 bool nf_ct_remove_expect(struct nf_conntrack_expect *exp)
 {
-	if (del_timer(&exp->timeout)) {
+	if (timer_delete(&exp->timeout)) {
 		nf_ct_unlink_expect(exp);
 		nf_ct_expect_put(exp);
 		return true;
@@ -214,11 +214,11 @@ nf_ct_find_expectation(struct net *net,
 	if (exp->flags & NF_CT_EXPECT_PERMANENT || !unlink) {
 		refcount_inc(&exp->use);
 		return exp;
-	} else if (del_timer(&exp->timeout)) {
+	} else if (timer_delete(&exp->timeout)) {
 		nf_ct_unlink_expect(exp);
 		return exp;
 	}
-	/* Undo exp->master refcnt increase, if del_timer() failed */
+	/* Undo exp->master refcnt increase, if timer_delete() failed */
 	nf_ct_put(exp->master);
 
 	return NULL;
@@ -520,7 +520,7 @@ void nf_ct_expect_iterate_destroy(bool (*iter)(struct nf_conntrack_expect *e, vo
 		hlist_for_each_entry_safe(exp, next,
 					  &nf_ct_expect_hash[i],
 					  hnode) {
-			if (iter(exp, data) && del_timer(&exp->timeout)) {
+			if (iter(exp, data) && timer_delete(&exp->timeout)) {
 				nf_ct_unlink_expect(exp);
 				nf_ct_expect_put(exp);
 			}
@@ -550,7 +550,7 @@ void nf_ct_expect_iterate_net(struct net *net,
 			if (!net_eq(nf_ct_exp_net(exp), net))
 				continue;
 
-			if (iter(exp, data) && del_timer(&exp->timeout)) {
+			if (iter(exp, data) && timer_delete(&exp->timeout)) {
 				nf_ct_unlink_expect_report(exp, portid, report);
 				nf_ct_expect_put(exp);
 			}
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index db23876..2cc0fde 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3448,7 +3448,7 @@ static int ctnetlink_del_expect(struct sk_buff *skb,
 
 		/* after list removal, usage count == 1 */
 		spin_lock_bh(&nf_conntrack_expect_lock);
-		if (del_timer(&exp->timeout)) {
+		if (timer_delete(&exp->timeout)) {
 			nf_ct_unlink_expect_report(exp, NETLINK_CB(skb).portid,
 						   nlmsg_report(info->nlh));
 			nf_ct_expect_put(exp);
@@ -3477,7 +3477,7 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 			const struct nlattr * const cda[])
 {
 	if (cda[CTA_EXPECT_TIMEOUT]) {
-		if (!del_timer(&x->timeout))
+		if (!timer_delete(&x->timeout))
 			return -ETIME;
 
 		x->timeout.expires = jiffies +
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 134e05d..882962f 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -381,7 +381,7 @@ static void
 __nfulnl_flush(struct nfulnl_instance *inst)
 {
 	/* timer holds a reference */
-	if (del_timer(&inst->timer))
+	if (timer_delete(&inst->timer))
 		instance_put(inst);
 	if (inst->skb)
 		__nfulnl_send(inst);
diff --git a/net/netrom/nr_loopback.c b/net/netrom/nr_loopback.c
index 511819f..7a9d765 100644
--- a/net/netrom/nr_loopback.c
+++ b/net/netrom/nr_loopback.c
@@ -68,6 +68,6 @@ static void nr_loopback_timer(struct timer_list *unused)
 
 void nr_loopback_clear(void)
 {
-	del_timer_sync(&loopback_timer);
+	timer_delete_sync(&loopback_timer);
 	skb_queue_purge(&loopback_queue);
 }
diff --git a/net/nfc/core.c b/net/nfc/core.c
index e58dc64..75ed8a9 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -464,7 +464,7 @@ int nfc_deactivate_target(struct nfc_dev *dev, u32 target_idx, u8 mode)
 	}
 
 	if (dev->ops->check_presence)
-		del_timer_sync(&dev->check_pres_timer);
+		timer_delete_sync(&dev->check_pres_timer);
 
 	dev->ops->deactivate_target(dev, dev->active_target, mode);
 	dev->active_target = NULL;
@@ -509,7 +509,7 @@ int nfc_data_exchange(struct nfc_dev *dev, u32 target_idx, struct sk_buff *skb,
 		}
 
 		if (dev->ops->check_presence)
-			del_timer_sync(&dev->check_pres_timer);
+			timer_delete_sync(&dev->check_pres_timer);
 
 		rc = dev->ops->im_transceive(dev, dev->active_target, skb, cb,
 					     cb_context);
@@ -1172,7 +1172,7 @@ void nfc_unregister_device(struct nfc_dev *dev)
 	device_unlock(&dev->dev);
 
 	if (dev->ops->check_presence) {
-		del_timer_sync(&dev->check_pres_timer);
+		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
 	}
 
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ceb87db..aa49334 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -148,7 +148,7 @@ static void nfc_hci_msg_rx_work(struct work_struct *work)
 static void __nfc_hci_cmd_completion(struct nfc_hci_dev *hdev, int err,
 				     struct sk_buff *skb)
 {
-	del_timer_sync(&hdev->cmd_timer);
+	timer_delete_sync(&hdev->cmd_timer);
 
 	if (hdev->cmd_pending_msg->cb)
 		hdev->cmd_pending_msg->cb(hdev->cmd_pending_msg->cb_context,
@@ -1046,7 +1046,7 @@ void nfc_hci_unregister_device(struct nfc_hci_dev *hdev)
 
 	mutex_unlock(&hdev->msg_tx_mutex);
 
-	del_timer_sync(&hdev->cmd_timer);
+	timer_delete_sync(&hdev->cmd_timer);
 	cancel_work_sync(&hdev->msg_tx_work);
 
 	cancel_work_sync(&hdev->msg_rx_work);
diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index e90f703..ce9c683 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -198,7 +198,7 @@ static void llc_shdlc_reset_t2(struct llc_shdlc *shdlc, int y_nr)
 
 	if (skb_queue_empty(&shdlc->ack_pending_q)) {
 		if (shdlc->t2_active) {
-			del_timer_sync(&shdlc->t2_timer);
+			timer_delete_sync(&shdlc->t2_timer);
 			shdlc->t2_active = false;
 
 			pr_debug("All sent frames acked. Stopped T2(retransmit)\n");
@@ -289,7 +289,7 @@ static void llc_shdlc_rcv_rej(struct llc_shdlc *shdlc, int y_nr)
 
 	if (llc_shdlc_x_lteq_y_lt_z(shdlc->dnr, y_nr, shdlc->ns)) {
 		if (shdlc->t2_active) {
-			del_timer_sync(&shdlc->t2_timer);
+			timer_delete_sync(&shdlc->t2_timer);
 			shdlc->t2_active = false;
 			pr_debug("Stopped T2(retransmit)\n");
 		}
@@ -342,7 +342,7 @@ static void llc_shdlc_connect_complete(struct llc_shdlc *shdlc, int r)
 {
 	pr_debug("result=%d\n", r);
 
-	del_timer_sync(&shdlc->connect_timer);
+	timer_delete_sync(&shdlc->connect_timer);
 
 	if (r == 0) {
 		shdlc->ns = 0;
@@ -526,7 +526,7 @@ static void llc_shdlc_handle_send_queue(struct llc_shdlc *shdlc)
 	       (shdlc->rnr == false)) {
 
 		if (shdlc->t1_active) {
-			del_timer_sync(&shdlc->t1_timer);
+			timer_delete_sync(&shdlc->t1_timer);
 			shdlc->t1_active = false;
 			pr_debug("Stopped T1(send ack)\n");
 		}
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 18be13f..27e863f 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -160,14 +160,14 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 static void local_cleanup(struct nfc_llcp_local *local)
 {
 	nfc_llcp_socket_release(local, false, ENXIO);
-	del_timer_sync(&local->link_timer);
+	timer_delete_sync(&local->link_timer);
 	skb_queue_purge(&local->tx_queue);
 	cancel_work_sync(&local->tx_work);
 	cancel_work_sync(&local->rx_work);
 	cancel_work_sync(&local->timeout_work);
 	kfree_skb(local->rx_pending);
 	local->rx_pending = NULL;
-	del_timer_sync(&local->sdreq_timer);
+	timer_delete_sync(&local->sdreq_timer);
 	cancel_work_sync(&local->sdreq_timeout_work);
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
@@ -1536,7 +1536,7 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
 	local->rx_pending = skb;
-	del_timer(&local->link_timer);
+	timer_delete(&local->link_timer);
 	schedule_work(&local->rx_work);
 }
 
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 1ec5955..0171bf3 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -565,8 +565,8 @@ static int nci_close_device(struct nci_dev *ndev)
 		 * there is a queued/running cmd_work
 		 */
 		flush_workqueue(ndev->cmd_wq);
-		del_timer_sync(&ndev->cmd_timer);
-		del_timer_sync(&ndev->data_timer);
+		timer_delete_sync(&ndev->cmd_timer);
+		timer_delete_sync(&ndev->data_timer);
 		mutex_unlock(&ndev->req_lock);
 		return 0;
 	}
@@ -597,7 +597,7 @@ static int nci_close_device(struct nci_dev *ndev)
 	/* Flush cmd wq */
 	flush_workqueue(ndev->cmd_wq);
 
-	del_timer_sync(&ndev->cmd_timer);
+	timer_delete_sync(&ndev->cmd_timer);
 
 	/* Clear flags except NCI_UNREG */
 	ndev->flags &= BIT(NCI_UNREG);
diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 3d36ea5..78f4131 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -42,7 +42,7 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	pr_debug("len %d, err %d\n", skb ? skb->len : 0, err);
 
 	/* data exchange is complete, stop the data timer */
-	del_timer_sync(&ndev->data_timer);
+	timer_delete_sync(&ndev->data_timer);
 	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
 
 	if (cb) {
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b911ab7..9eeb862 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -347,7 +347,7 @@ void nci_rsp_packet(struct nci_dev *ndev, struct sk_buff *skb)
 	__u16 rsp_opcode = nci_opcode(skb->data);
 
 	/* we got a rsp, stop the cmd timer */
-	del_timer(&ndev->cmd_timer);
+	timer_delete(&ndev->cmd_timer);
 
 	pr_debug("NCI RX: MT=rsp, PBF=%d, GID=0x%x, OID=0x%x, plen=%d\n",
 		 nci_pbf(skb->data),
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3e9ddf7..d4dba06 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -581,7 +581,7 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
-	del_timer_sync(&pkc->retire_blk_timer);
+	timer_delete_sync(&pkc->retire_blk_timer);
 }
 
 static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
index 0f77ae8..9f9629e 100644
--- a/net/rose/rose_link.c
+++ b/net/rose/rose_link.c
@@ -32,7 +32,7 @@ static void rose_transmit_restart_request(struct rose_neigh *neigh);
 
 void rose_start_ftimer(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->ftimer);
+	timer_delete(&neigh->ftimer);
 
 	neigh->ftimer.function = rose_ftimer_expiry;
 	neigh->ftimer.expires  =
@@ -43,7 +43,7 @@ void rose_start_ftimer(struct rose_neigh *neigh)
 
 static void rose_start_t0timer(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->t0timer);
+	timer_delete(&neigh->t0timer);
 
 	neigh->t0timer.function = rose_t0timer_expiry;
 	neigh->t0timer.expires  =
@@ -54,12 +54,12 @@ static void rose_start_t0timer(struct rose_neigh *neigh)
 
 void rose_stop_ftimer(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->ftimer);
+	timer_delete(&neigh->ftimer);
 }
 
 void rose_stop_t0timer(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->t0timer);
+	timer_delete(&neigh->t0timer);
 }
 
 int rose_ftimer_running(struct rose_neigh *neigh)
diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index 036d92c..b538e39 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -124,7 +124,7 @@ void __exit rose_loopback_clear(void)
 {
 	struct sk_buff *skb;
 
-	del_timer(&loopback_timer);
+	timer_delete(&loopback_timer);
 
 	while ((skb = skb_dequeue(&loopback_queue)) != NULL) {
 		skb->sk = NULL;
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index fee772b..2dd6bd3 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -227,8 +227,8 @@ static void rose_remove_neigh(struct rose_neigh *rose_neigh)
 {
 	struct rose_neigh *s;
 
-	del_timer_sync(&rose_neigh->ftimer);
-	del_timer_sync(&rose_neigh->t0timer);
+	timer_delete_sync(&rose_neigh->ftimer);
+	timer_delete_sync(&rose_neigh->t0timer);
 
 	skb_queue_purge(&rose_neigh->queue);
 
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 8e477f7..fec59d9 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -469,7 +469,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 out:
 	if (__rxrpc_call_is_complete(call)) {
-		del_timer_sync(&call->timer);
+		timer_delete_sync(&call->timer);
 		if (!test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
 			rxrpc_disconnect_call(call);
 		if (call->security)
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index c4c8b46..fce58be 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -688,7 +688,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 {
 	struct rxrpc_call *call = container_of(work, struct rxrpc_call, destroyer);
 
-	del_timer_sync(&call->timer);
+	timer_delete_sync(&call->timer);
 
 	rxrpc_cleanup_tx_buffers(call);
 	rxrpc_cleanup_rx_buffers(call);
@@ -711,7 +711,7 @@ void rxrpc_cleanup_call(struct rxrpc_call *call)
 	ASSERTCMP(__rxrpc_call_state(call), ==, RXRPC_CALL_COMPLETE);
 	ASSERT(test_bit(RXRPC_CALL_RELEASED, &call->flags));
 
-	del_timer(&call->timer);
+	timer_delete(&call->timer);
 
 	if (rcu_read_lock_held())
 		/* Can't use the rxrpc workqueue as we need to cancel/flush
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index db00991..63bbcc5 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -818,7 +818,7 @@ void rxrpc_clean_up_local_conns(struct rxrpc_local *local)
 
 	local->kill_all_client_conns = true;
 
-	del_timer_sync(&local->client_conn_reap_timer);
+	timer_delete_sync(&local->client_conn_reap_timer);
 
 	while ((conn = list_first_entry_or_null(&local->idle_client_conns,
 						struct rxrpc_connection, cache_link))) {
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 2f1fd1e..8ac22dd 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -314,9 +314,9 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	       !conn->channels[3].call);
 	ASSERT(list_empty(&conn->cache_link));
 
-	del_timer_sync(&conn->timer);
+	timer_delete_sync(&conn->timer);
 	cancel_work_sync(&conn->processor); /* Processing may restart the timer */
-	del_timer_sync(&conn->timer);
+	timer_delete_sync(&conn->timer);
 
 	write_lock(&rxnet->conn_lock);
 	list_del_init(&conn->proc_link);
@@ -365,7 +365,7 @@ void rxrpc_put_connection(struct rxrpc_connection *conn,
 	dead = __refcount_dec_and_test(&conn->ref, &r);
 	trace_rxrpc_conn(debug_id, r - 1, why);
 	if (dead) {
-		del_timer(&conn->timer);
+		timer_delete(&conn->timer);
 		cancel_work(&conn->processor);
 
 		if (in_softirq() || work_busy(&conn->processor) ||
@@ -470,7 +470,7 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)
 
 	atomic_dec(&rxnet->nr_conns);
 
-	del_timer_sync(&rxnet->service_conn_reap_timer);
+	timer_delete_sync(&rxnet->service_conn_reap_timer);
 	rxrpc_queue_work(&rxnet->service_conn_reaper);
 	flush_workqueue(rxrpc_workqueue);
 
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index a4c135d..9a98341 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -105,10 +105,10 @@ static __net_exit void rxrpc_exit_net(struct net *net)
 	struct rxrpc_net *rxnet = rxrpc_net(net);
 
 	rxnet->live = false;
-	del_timer_sync(&rxnet->peer_keepalive_timer);
+	timer_delete_sync(&rxnet->peer_keepalive_timer);
 	cancel_work_sync(&rxnet->peer_keepalive_work);
 	/* Remove the timer again as the worker may have restarted it. */
-	del_timer_sync(&rxnet->peer_keepalive_timer);
+	timer_delete_sync(&rxnet->peer_keepalive_timer);
 	rxrpc_destroy_all_calls(rxnet);
 	rxrpc_destroy_all_connections(rxnet);
 	rxrpc_destroy_all_peers(rxnet);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 93c36af..f3b8203 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -555,7 +555,7 @@ static void fq_pie_destroy(struct Qdisc *sch)
 
 	tcf_block_put(q->block);
 	q->p_params.tupdate = 0;
-	del_timer_sync(&q->adapt_timer);
+	timer_delete_sync(&q->adapt_timer);
 	kvfree(q->flows);
 }
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 14ab2f4..514b1b6 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -567,7 +567,7 @@ EXPORT_SYMBOL_GPL(netdev_watchdog_up);
 static void netdev_watchdog_down(struct net_device *dev)
 {
 	netif_tx_lock_bh(dev);
-	if (del_timer(&dev->watchdog_timer))
+	if (timer_delete(&dev->watchdog_timer))
 		netdev_put(dev, &dev->watchdog_dev_tracker);
 	netif_tx_unlock_bh(dev);
 }
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index bb1fa9a..3771d00 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -545,7 +545,7 @@ static void pie_destroy(struct Qdisc *sch)
 	struct pie_sched_data *q = qdisc_priv(sch);
 
 	q->params.tupdate = 0;
-	del_timer_sync(&q->adapt_timer);
+	timer_delete_sync(&q->adapt_timer);
 }
 
 static struct Qdisc_ops pie_qdisc_ops __read_mostly = {
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index ef8a2af..1ba3e0b 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -218,7 +218,7 @@ static void red_destroy(struct Qdisc *sch)
 
 	tcf_qevent_destroy(&q->qe_mark, sch);
 	tcf_qevent_destroy(&q->qe_early_drop, sch);
-	del_timer_sync(&q->adapt_timer);
+	timer_delete_sync(&q->adapt_timer);
 	red_offload(sch, false);
 	qdisc_put(q->qdisc);
 }
@@ -297,7 +297,7 @@ static int __red_change(struct Qdisc *sch, struct nlattr **tb,
 		      max_P);
 	red_set_vars(&q->vars);
 
-	del_timer(&q->adapt_timer);
+	timer_delete(&q->adapt_timer);
 	if (ctl->flags & TC_RED_ADAPTATIVE)
 		mod_timer(&q->adapt_timer, jiffies + HZ/2);
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59..9ed197e 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -696,7 +696,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	rtnl_kfree_skbs(to_free, tail);
 	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
 
-	del_timer(&q->perturb_timer);
+	timer_delete(&q->perturb_timer);
 	if (q->perturb_period) {
 		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
 		get_random_bytes(&q->perturbation, sizeof(q->perturbation));
@@ -722,7 +722,7 @@ static void sfq_destroy(struct Qdisc *sch)
 
 	tcf_block_put(q->block);
 	WRITE_ONCE(q->perturb_period, 0);
-	del_timer_sync(&q->perturb_timer);
+	timer_delete_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
 	kfree(q->red_parms);
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 0b0794f..760152e 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -362,7 +362,7 @@ void sctp_association_free(struct sctp_association *asoc)
 	 * on our state.
 	 */
 	for (i = SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; ++i) {
-		if (del_timer(&asoc->timers[i]))
+		if (timer_delete(&asoc->timers[i]))
 			sctp_association_put(asoc);
 	}
 
@@ -1521,7 +1521,7 @@ void sctp_assoc_rwnd_increase(struct sctp_association *asoc, unsigned int len)
 
 		/* Stop the SACK timer.  */
 		timer = &asoc->timers[SCTP_EVENT_TIMEOUT_SACK];
-		if (del_timer(timer))
+		if (timer_delete(timer))
 			sctp_association_put(asoc);
 	}
 }
diff --git a/net/sctp/input.c b/net/sctp/input.c
index a8a254a..0c0d275 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -446,7 +446,7 @@ void sctp_icmp_proto_unreachable(struct sock *sk,
 		pr_debug("%s: unrecognized next header type "
 			 "encountered!\n", __func__);
 
-		if (del_timer(&t->proto_unreach_timer))
+		if (timer_delete(&t->proto_unreach_timer))
 			sctp_transport_put(t);
 
 		sctp_do_sm(net, SCTP_EVENT_T_OTHER,
diff --git a/net/sctp/output.c b/net/sctp/output.c
index a63df05..23e9630 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -312,7 +312,7 @@ static enum sctp_xmit sctp_packet_bundle_sack(struct sctp_packet *pkt,
 					       SCTP_MIB_OUTCTRLCHUNKS);
 				asoc->stats.octrlchunks++;
 				asoc->peer.sack_needed = 0;
-				if (del_timer(timer))
+				if (timer_delete(timer))
 					sctp_association_put(asoc);
 			}
 		}
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index 0dc6b8a..f6b8c13 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1630,8 +1630,7 @@ static void sctp_check_transmitted(struct sctp_outq *q,
 			 * as the receiver acknowledged any data.
 			 */
 			if (asoc->state == SCTP_STATE_SHUTDOWN_PENDING &&
-			    del_timer(&asoc->timers
-				[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]))
+			    timer_delete(&asoc->timers[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]))
 					sctp_association_put(asoc);
 
 			/* Mark the destination transport address as
@@ -1688,7 +1687,7 @@ static void sctp_check_transmitted(struct sctp_outq *q,
 		 * address.
 		 */
 		if (!transport->flight_size) {
-			if (del_timer(&transport->T3_rtx_timer))
+			if (timer_delete(&transport->T3_rtx_timer))
 				sctp_transport_put(transport);
 		} else if (restart_timer) {
 			if (!mod_timer(&transport->T3_rtx_timer,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5407a39..8c3b80c 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -695,7 +695,7 @@ static void sctp_free_addr_wq(struct net *net)
 	struct sctp_sockaddr_entry *temp;
 
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	del_timer(&net->sctp.addr_wq_timer);
+	timer_delete(&net->sctp.addr_wq_timer);
 	list_for_each_entry_safe(addrw, temp, &net->sctp.addr_waitq, list) {
 		list_del(&addrw->list);
 		kfree(addrw);
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 23d6633..3aa5da5 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -734,7 +734,7 @@ static void sctp_cmd_hb_timers_stop(struct sctp_cmd_seq *cmds,
 
 	list_for_each_entry(t, &asoc->peer.transport_addr_list,
 			transports) {
-		if (del_timer(&t->hb_timer))
+		if (timer_delete(&t->hb_timer))
 			sctp_transport_put(t);
 	}
 }
@@ -747,7 +747,7 @@ static void sctp_cmd_t3_rtx_timers_stop(struct sctp_cmd_seq *cmds,
 
 	list_for_each_entry(t, &asoc->peer.transport_addr_list,
 			transports) {
-		if (del_timer(&t->T3_rtx_timer))
+		if (timer_delete(&t->T3_rtx_timer))
 			sctp_transport_put(t);
 	}
 }
@@ -1557,7 +1557,7 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
 
 		case SCTP_CMD_TIMER_STOP:
 			timer = &asoc->timers[cmd->obj.to];
-			if (del_timer(timer))
+			if (timer_delete(timer))
 				sctp_association_put(asoc);
 			break;
 
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index bfcff6d..f205556 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -576,7 +576,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 			struct sctp_transport *t;
 
 			t = asoc->strreset_chunk->transport;
-			if (del_timer(&t->reconf_timer))
+			if (timer_delete(&t->reconf_timer))
 				sctp_transport_put(t);
 
 			sctp_chunk_put(asoc->strreset_chunk);
@@ -825,7 +825,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 			struct sctp_transport *t;
 
 			t = asoc->strreset_chunk->transport;
-			if (del_timer(&t->reconf_timer))
+			if (timer_delete(&t->reconf_timer))
 				sctp_transport_put(t);
 
 			sctp_chunk_put(asoc->strreset_chunk);
@@ -1076,7 +1076,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 	/* remove everything for this reconf request */
 	if (!asoc->strreset_outstanding) {
 		t = asoc->strreset_chunk->transport;
-		if (del_timer(&t->reconf_timer))
+		if (timer_delete(&t->reconf_timer))
 			sctp_transport_put(t);
 
 		sctp_chunk_put(asoc->strreset_chunk);
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 2abe45a..59675f6 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -118,7 +118,7 @@ fail:
 void sctp_transport_free(struct sctp_transport *transport)
 {
 	/* Try to delete the heartbeat timer.  */
-	if (del_timer(&transport->hb_timer))
+	if (timer_delete(&transport->hb_timer))
 		sctp_transport_put(transport);
 
 	/* Delete the T3_rtx timer if it's active.
@@ -126,17 +126,17 @@ void sctp_transport_free(struct sctp_transport *transport)
 	 * structure hang around in memory since we know
 	 * the transport is going away.
 	 */
-	if (del_timer(&transport->T3_rtx_timer))
+	if (timer_delete(&transport->T3_rtx_timer))
 		sctp_transport_put(transport);
 
-	if (del_timer(&transport->reconf_timer))
+	if (timer_delete(&transport->reconf_timer))
 		sctp_transport_put(transport);
 
-	if (del_timer(&transport->probe_timer))
+	if (timer_delete(&transport->probe_timer))
 		sctp_transport_put(transport);
 
 	/* Delete the ICMP proto unreachable timer if it's active. */
-	if (del_timer(&transport->proto_unreach_timer))
+	if (timer_delete(&transport->proto_unreach_timer))
 		sctp_transport_put(transport);
 
 	sctp_transport_put(transport);
@@ -829,7 +829,7 @@ void sctp_transport_reset(struct sctp_transport *t)
 void sctp_transport_immediate_rtx(struct sctp_transport *t)
 {
 	/* Stop pending T3_rtx_timer */
-	if (del_timer(&t->T3_rtx_timer))
+	if (timer_delete(&t->T3_rtx_timer))
 		sctp_transport_put(t);
 
 	sctp_retransmit(&t->asoc->outqueue, t, SCTP_RTXR_T3_RTX);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245c..0eab154 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1167,7 +1167,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 
 	/* Turn off autodisconnect */
-	del_timer_sync(&xprt->timer);
+	timer_delete_sync(&xprt->timer);
 	return 0;
 }
 
@@ -2138,7 +2138,7 @@ static void xprt_destroy(struct rpc_xprt *xprt)
 	 * can only run *before* del_time_sync(), never after.
 	 */
 	spin_lock(&xprt->transport_lock);
-	del_timer_sync(&xprt->timer);
+	timer_delete_sync(&xprt->timer);
 	spin_unlock(&xprt->transport_lock);
 
 	/*
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 500320e..ccf5e42 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -638,7 +638,7 @@ static void tipc_node_delete(struct tipc_node *node)
 	trace_tipc_node_delete(node, true, " ");
 	tipc_node_delete_from_list(node);
 
-	del_timer_sync(&node->timer);
+	timer_delete_sync(&node->timer);
 	tipc_node_put(node);
 }
 
diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c
index 05d49ad..621adda 100644
--- a/net/tipc/subscr.c
+++ b/net/tipc/subscr.c
@@ -177,7 +177,7 @@ void tipc_sub_unsubscribe(struct tipc_subscription *sub)
 {
 	tipc_nametbl_unsubscribe(sub);
 	if (sub->evt.s.timeout != TIPC_WAIT_FOREVER)
-		del_timer_sync(&sub->timer);
+		timer_delete_sync(&sub->timer);
 	list_del(&sub->sub_list);
 	tipc_sub_put(sub);
 }
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9e6b319..dcce326 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1722,7 +1722,7 @@ void wiphy_delayed_work_queue(struct wiphy *wiphy,
 	trace_wiphy_delayed_work_queue(wiphy, &dwork->work, delay);
 
 	if (!delay) {
-		del_timer(&dwork->timer);
+		timer_delete(&dwork->timer);
 		wiphy_work_queue(wiphy, &dwork->work);
 		return;
 	}
@@ -1737,7 +1737,7 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 {
 	lockdep_assert_held(&wiphy->mtx);
 
-	del_timer_sync(&dwork->timer);
+	timer_delete_sync(&dwork->timer);
 	wiphy_work_cancel(wiphy, &dwork->work);
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_cancel);
@@ -1747,7 +1747,7 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
 {
 	lockdep_assert_held(&wiphy->mtx);
 
-	del_timer_sync(&dwork->timer);
+	timer_delete_sync(&dwork->timer);
 	wiphy_work_flush(wiphy, &dwork->work);
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_flush);
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index 5460b91..37b1904 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -55,7 +55,7 @@ static void x25_t20timer_expiry(struct timer_list *t)
 
 static inline void x25_stop_t20timer(struct x25_neigh *nb)
 {
-	del_timer(&nb->t20timer);
+	timer_delete(&nb->t20timer);
 }
 
 /*
diff --git a/net/x25/x25_timer.c b/net/x25/x25_timer.c
index 9376365..e4c5ad5 100644
--- a/net/x25/x25_timer.c
+++ b/net/x25/x25_timer.c
@@ -41,7 +41,7 @@ void x25_start_heartbeat(struct sock *sk)
 
 void x25_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	timer_delete(&sk->sk_timer);
 }
 
 void x25_start_t2timer(struct sock *sk)
@@ -74,7 +74,7 @@ void x25_start_t23timer(struct sock *sk)
 
 void x25_stop_timer(struct sock *sk)
 {
-	del_timer(&x25_sk(sk)->timer);
+	timer_delete(&x25_sk(sk)->timer);
 }
 
 unsigned long x25_display_timer(struct sock *sk)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 30970d4..143ac3a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -462,7 +462,7 @@ void xfrm_policy_destroy(struct xfrm_policy *policy)
 {
 	BUG_ON(!policy->walk.dead);
 
-	if (del_timer(&policy->timer) || del_timer(&policy->polq.hold_timer))
+	if (timer_delete(&policy->timer) || timer_delete(&policy->polq.hold_timer))
 		BUG();
 
 	xfrm_dev_policy_free(policy);
@@ -487,11 +487,11 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
 
 	atomic_inc(&policy->genid);
 
-	if (del_timer(&policy->polq.hold_timer))
+	if (timer_delete(&policy->polq.hold_timer))
 		xfrm_pol_put(policy);
 	skb_queue_purge(&policy->polq.hold_queue);
 
-	if (del_timer(&policy->timer))
+	if (timer_delete(&policy->timer))
 		xfrm_pol_put(policy);
 
 	/* XXX: Flush state cache */
@@ -1469,7 +1469,7 @@ static void xfrm_policy_requeue(struct xfrm_policy *old,
 
 	spin_lock_bh(&pq->hold_queue.lock);
 	skb_queue_splice_init(&pq->hold_queue, &list);
-	if (del_timer(&pq->hold_timer))
+	if (timer_delete(&pq->hold_timer))
 		xfrm_pol_put(old);
 	spin_unlock_bh(&pq->hold_queue.lock);
 
@@ -3004,7 +3004,7 @@ static int xdst_queue_output(struct net *net, struct sock *sk, struct sk_buff *s
 
 	sched_next = jiffies + pq->timeout;
 
-	if (del_timer(&pq->hold_timer)) {
+	if (timer_delete(&pq->hold_timer)) {
 		if (time_before(pq->hold_timer.expires, sched_next))
 			sched_next = pq->hold_timer.expires;
 		xfrm_pol_put(pol);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d896c3f..341d79e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -598,7 +598,7 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
 		x->mode_cbs->destroy_state(x);
 	hrtimer_cancel(&x->mtimer);
-	del_timer_sync(&x->rtimer);
+	timer_delete_sync(&x->rtimer);
 	kfree(x->aead);
 	kfree(x->aalg);
 	kfree(x->ealg);
diff --git a/samples/connector/cn_test.c b/samples/connector/cn_test.c
index 0958a17..73d50b4 100644
--- a/samples/connector/cn_test.c
+++ b/samples/connector/cn_test.c
@@ -172,7 +172,7 @@ static int cn_test_init(void)
 
 static void cn_test_fini(void)
 {
-	del_timer_sync(&cn_test_timer);
+	timer_delete_sync(&cn_test_timer);
 	cn_del_callback(&cn_test_id);
 	cn_test_id.val--;
 	cn_del_callback(&cn_test_id);
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index d0ee900..dac67c3 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -82,7 +82,7 @@ static int simple_thread(void *arg)
 	while (!kthread_should_stop())
 		simple_thread_func(count++);
 
-	del_timer(&mytimer);
+	timer_delete(&mytimer);
 	cancel_work_sync(&trace_work);
 
 	/*
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d774b9b..1de4b90 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1152,7 +1152,7 @@ static int snd_timer_s_stop(struct snd_timer * timer)
 	unsigned long jiff;
 
 	priv = (struct snd_timer_system_private *) timer->private_data;
-	del_timer(&priv->tlist);
+	timer_delete(&priv->tlist);
 	jiff = jiffies;
 	if (time_before(jiff, priv->last_expires))
 		timer->sticks = priv->last_expires - jiff;
@@ -1167,7 +1167,7 @@ static int snd_timer_s_close(struct snd_timer *timer)
 	struct snd_timer_system_private *priv;
 
 	priv = (struct snd_timer_system_private *)timer->private_data;
-	del_timer_sync(&priv->tlist);
+	timer_delete_sync(&priv->tlist);
 	return 0;
 }
 
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index eb8a68a..4b02ec1 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -261,7 +261,7 @@ static int loopback_snd_timer_start(struct loopback_pcm *dpcm)
 /* call in cable->lock */
 static inline int loopback_jiffies_timer_stop(struct loopback_pcm *dpcm)
 {
-	del_timer(&dpcm->timer);
+	timer_delete(&dpcm->timer);
 	dpcm->timer.expires = 0;
 
 	return 0;
@@ -292,7 +292,7 @@ static int loopback_snd_timer_stop(struct loopback_pcm *dpcm)
 
 static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 {
-	del_timer_sync(&dpcm->timer);
+	timer_delete_sync(&dpcm->timer);
 
 	return 0;
 }
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index c1a3efb..1d923cb 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -279,7 +279,7 @@ static int dummy_systimer_stop(struct snd_pcm_substream *substream)
 {
 	struct dummy_systimer_pcm *dpcm = substream->runtime->private_data;
 	spin_lock(&dpcm->lock);
-	del_timer(&dpcm->timer);
+	timer_delete(&dpcm->timer);
 	spin_unlock(&dpcm->lock);
 	return 0;
 }
diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 8e3318e..a63e755 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -197,7 +197,7 @@ static void snd_mpu401_uart_remove_timer (struct snd_mpu401 *mpu, int input)
 		mpu->timer_invoked &= input ? ~MPU401_MODE_INPUT_TIMER :
 			~MPU401_MODE_OUTPUT_TIMER;
 		if (! mpu->timer_invoked)
-			del_timer(&mpu->timer);
+			timer_delete(&mpu->timer);
 	}
 	spin_unlock_irqrestore (&mpu->timer_lock, flags);
 }
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 946184a..dffcdf9 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -412,7 +412,7 @@ static void snd_mtpav_add_output_timer(struct mtpav *chip)
 /* spinlock held! */
 static void snd_mtpav_remove_output_timer(struct mtpav *chip)
 {
-	del_timer(&chip->timer);
+	timer_delete(&chip->timer);
 }
 
 /*
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index 75de129..9fc78b7 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -74,7 +74,7 @@ void snd_opl3_synth_cleanup(struct snd_opl3 * opl3)
 	/* Stop system timer */
 	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
 	if (opl3->sys_timer_status) {
-		del_timer(&opl3->tlist);
+		timer_delete(&opl3->tlist);
 		opl3->sys_timer_status = 0;
 	}
 	spin_unlock_irqrestore(&opl3->sys_timer_lock, flags);
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index f66e016..1857a78 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -166,7 +166,7 @@ static inline void snd_uart16550_add_timer(struct snd_uart16550 *uart)
 static inline void snd_uart16550_del_timer(struct snd_uart16550 *uart)
 {
 	if (uart->timer_running) {
-		del_timer(&uart->buffer_timer);
+		timer_delete(&uart->buffer_timer);
 		uart->timer_running = 0;
 	}
 }
diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 165fdda..657b331 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -99,7 +99,7 @@ void snd_ak4117_reinit(struct ak4117 *chip)
 {
 	unsigned char old = chip->regmap[AK4117_REG_PWRDN], reg;
 
-	del_timer(&chip->timer);
+	timer_delete(&chip->timer);
 	chip->init = 1;
 	/* bring the chip to reset state and powerdown state */
 	reg_write(chip, AK4117_REG_PWRDN, 0);
diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 9234d4f..0162352 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -364,7 +364,7 @@ static void stop_voice(struct snd_emu8k_pcm *rec, int ch)
 	/* stop timer */
 	spin_lock_irqsave(&rec->timer_lock, flags);
 	if (rec->timer_running) {
-		del_timer(&rec->timer);
+		timer_delete(&rec->timer);
 		rec->timer_running = 0;
 	}
 	spin_unlock_irqrestore(&rec->timer_lock, flags);
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index 618366d..d2908fc 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -125,7 +125,7 @@ static int snd_sb8dsp_midi_output_close(struct snd_rawmidi_substream *substream)
 	struct snd_sb *chip;
 
 	chip = substream->rmidi->private_data;
-	del_timer_sync(&chip->midi_timer);
+	timer_delete_sync(&chip->midi_timer);
 	spin_lock_irqsave(&chip->open_lock, flags);
 	chip->open &= ~(SB_OPEN_MIDI_OUTPUT | SB_OPEN_MIDI_OUTPUT_TRIGGER);
 	chip->midi_substream_output = NULL;
@@ -174,7 +174,7 @@ static void snd_sb8dsp_midi_output_write(struct snd_rawmidi_substream *substream
 		spin_lock_irqsave(&chip->open_lock, flags);
 		if (snd_rawmidi_transmit_peek(substream, &byte, 1) != 1) {
 			chip->open &= ~SB_OPEN_MIDI_OUTPUT_TRIGGER;
-			del_timer(&chip->midi_timer);
+			timer_delete(&chip->midi_timer);
 			spin_unlock_irqrestore(&chip->open_lock, flags);
 			break;
 		}
diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index ead8cbe..fcc2a0d 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -157,7 +157,7 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 			} else {
 				if (midi->istimer) {
 					if (--midi->istimer <= 0)
-						del_timer(&midi->timer);
+						timer_delete(&midi->timer);
 				}
 				midi->mode[midi->output_mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
 				spin_unlock_irqrestore (&midi->virtual, flags);
@@ -212,7 +212,7 @@ static void snd_wavefront_midi_output_write(snd_wavefront_card_t *card)
 			      __timer:
 				if (midi->istimer) {
 					if (--midi->istimer <= 0)
-						del_timer(&midi->timer);
+						timer_delete(&midi->timer);
 				}
 				midi->mode[mpu] &= ~MPU401_MODE_OUTPUT_TRIGGER;
 				spin_unlock_irqrestore (&midi->virtual, flags);
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 5a84591..65100f9 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -518,7 +518,7 @@ static void snd_card_asihpi_pcm_timer_stop(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
 	dpcm->respawn_timer = 0;
-	del_timer(&dpcm->timer);
+	timer_delete(&dpcm->timer);
 }
 
 static void snd_card_asihpi_pcm_int_start(struct snd_pcm_substream *substream)
diff --git a/sound/pci/ctxfi/cttimer.c b/sound/pci/ctxfi/cttimer.c
index 0bb447c..89e47fa 100644
--- a/sound/pci/ctxfi/cttimer.c
+++ b/sound/pci/ctxfi/cttimer.c
@@ -112,7 +112,7 @@ static void ct_systimer_stop(struct ct_timer_instance *ti)
 
 	spin_lock_irqsave(&ti->lock, flags);
 	ti->running = 0;
-	del_timer(&ti->timer);
+	timer_delete(&ti->timer);
 	spin_unlock_irqrestore(&ti->lock, flags);
 }
 
diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index 47b2c02..2ef5918 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -264,7 +264,7 @@ static void snd_echo_midi_output_trigger(struct snd_rawmidi_substream *substream
 		if (chip->tinuse) {
 			chip->tinuse = 0;
 			spin_unlock_irq(&chip->lock);
-			del_timer_sync(&chip->timer);
+			timer_delete_sync(&chip->timer);
 			dev_dbg(chip->card->dev, "Timer removed\n");
 			return;
 		}
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fd3dfba..dc326fa 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1427,7 +1427,7 @@ static void snd_hdsp_midi_output_trigger(struct snd_rawmidi_substream *substream
 		}
 	} else {
 		if (hmidi->istimer && --hmidi->istimer <= 0)
-			del_timer (&hmidi->timer);
+			timer_delete(&hmidi->timer);
 	}
 	spin_unlock_irqrestore (&hmidi->lock, flags);
 	if (up)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index f89718b..1935de0 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1978,7 +1978,7 @@ snd_hdspm_midi_output_trigger(struct snd_rawmidi_substream *substream, int up)
 		}
 	} else {
 		if (hmidi->istimer && --hmidi->istimer <= 0)
-			del_timer (&hmidi->timer);
+			timer_delete(&hmidi->timer);
 	}
 	spin_unlock_irqrestore (&hmidi->lock, flags);
 	if (up)
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 39bf51f..5a93f45 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -354,7 +354,7 @@ static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
 
-	del_timer_sync(&dreamcastcard->timer);
+	timer_delete_sync(&dreamcastcard->timer);
 	cancel_work_sync(&dreamcastcard->spu_dma_work);
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 343e3bc..dba78ef 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -4286,7 +4286,7 @@ static void rt5645_i2c_remove(struct i2c_client *i2c)
 	 * Since the rt5645_btn_check_callback() can queue jack_detect_work,
 	 * the timer need to be delted first
 	 */
-	del_timer_sync(&rt5645->btn_check_timer);
+	timer_delete_sync(&rt5645->btn_check_timer);
 
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
@@ -4318,7 +4318,7 @@ static int rt5645_sys_suspend(struct device *dev)
 {
 	struct rt5645_priv *rt5645 = dev_get_drvdata(dev);
 
-	del_timer_sync(&rt5645->btn_check_timer);
+	timer_delete_sync(&rt5645->btn_check_timer);
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 1daf0be..de5f876 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -301,7 +301,7 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
 
 	info->send_message(msg, info);
 
-	del_timer(&info->stream_timer[substream->stream].timer);
+	timer_delete(&info->stream_timer[substream->stream].timer);
 
 	rtd->dai_link->ignore_suspend = 0;
 
@@ -452,7 +452,7 @@ static int imx_rpmsg_terminate_all(struct snd_soc_component *component,
 		info->msg[RX_POINTER].r_msg.param.buffer_offset = 0;
 	}
 
-	del_timer(&info->stream_timer[substream->stream].timer);
+	timer_delete(&info->stream_timer[substream->stream].timer);
 
 	return imx_rpmsg_insert_workqueue(substream, msg, info);
 }
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 8a44236..9b8cb80 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -303,7 +303,7 @@ static void cx81801_close(struct tty_struct *tty)
 	struct snd_soc_component *component = tty->disc_data;
 	struct snd_soc_dapm_context *dapm;
 
-	del_timer_sync(&cx81801_timer);
+	timer_delete_sync(&cx81801_timer);
 
 	/* Prevent the hook switch from further changing the DAPM pins */
 	INIT_LIST_HEAD(&ams_delta_hook_switch.pins);
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 826ac87..dcdd7e9 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1553,7 +1553,7 @@ void snd_usbmidi_disconnect(struct list_head *p)
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
-	del_timer_sync(&umidi->error_timer);
+	timer_delete_sync(&umidi->error_timer);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];

